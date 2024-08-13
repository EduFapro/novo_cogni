import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/participant/participant_repository.dart';
import 'package:novo_cogni/app/recording_file/recording_file_repository.dart';
import 'package:novo_cogni/app/task_instance/task_instance_repository.dart';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/module/module_entity.dart';
import '../../app/module/module_repository.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/module_instance/module_instance_repository.dart';
import '../../app/participant/participant_entity.dart';
import '../../app/task/task_entity.dart';
import '../../app/task/task_repository.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../file_management/file_encryptor.dart';
import '../../global/user_service.dart';

class UserProfileScreenController extends GetxController {
  final UserService userService = Get.find<UserService>();
  final ParticipantRepository participantRepository =
      Get.find<ParticipantRepository>();
  final TaskInstanceRepository taskInstanceRepository =
      Get.find<TaskInstanceRepository>();
  final TaskRepository taskRepository = Get.find<TaskRepository>();
  final ModuleInstanceRepository moduleInstanceRepository =
      Get.find<ModuleInstanceRepository>();
  final ModuleRepository moduleRepository = Get.find<ModuleRepository>();
  final RecordingRepository recordingRepository =
      Get.find<RecordingRepository>();

  Rxn<EvaluatorEntity> userAvaliador = Rxn<EvaluatorEntity>();
  RxList<EvaluationEntity> evaluations = <EvaluationEntity>[].obs;
  RxMap<int, ParticipantEntity> participants = <int, ParticipantEntity>{}.obs;
  RxMap<int, ModuleEntity> modules = <int, ModuleEntity>{}.obs;
  RxMap<int, TaskEntity> tasks = <int, TaskEntity>{}.obs;
  RxMap<int, String> taskRecordingPaths =
      RxMap<int, String>();
  RxMap<EvaluationEntity, Map<ModuleInstanceEntity, List<TaskInstanceEntity>>>
      evaluationMap = RxMap({});

  var isPlayingPlayback = false.obs;


  late final AudioPlayer _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    userAvaliador.value = userService.user.value;
    fetchAllData();
    _audioPlayer = AudioPlayer();
  }

  void fetchAllData() async {
    evaluations.assignAll(userService.evaluations);
    for (var evaluation in evaluations) {
      print("Processing evaluation: ${evaluation.evaluationID}");
      var moduleInstances = await moduleInstanceRepository.getModuleInstancesByEvaluationId(evaluation.evaluationID!);

      if (evaluationMap[evaluation] == null) {
        evaluationMap[evaluation] = {};
      }

      for (var moduleInstance in moduleInstances) {
        print("Adding module: ${moduleInstance.moduleID} to evaluation: ${evaluation.evaluationID}");
        List<TaskInstanceEntity> taskList = await _processModuleInstance(moduleInstance);
        evaluationMap[evaluation]![moduleInstance] = taskList;
      }
    }
  }

  Future<List<TaskInstanceEntity>> _processModuleInstance(ModuleInstanceEntity moduleInstance) async {
    List<TaskInstanceEntity> taskList = [];
    var taskInstances = await taskInstanceRepository.getTaskInstancesByModuleInstanceId(moduleInstance.moduleInstanceID!);
    for (var taskInstance in taskInstances) {
      tasks[taskInstance.taskID] = (await taskRepository.getTask(taskInstance.taskID))!;
      taskRecordingPaths[taskInstance.taskInstanceID!] = (await recordingRepository.getRecordingByTaskInstanceId(taskInstance.taskInstanceID!))?.filePath ?? "";
      taskList.add(taskInstance);
    }
    return taskList;
  }



  Future<void> playRecorded(String playbackPath) async {
    print(playbackPath);
    final String encryptedFilePath = playbackPath;

    final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
    try {
      final Uint8List decryptedAudioBytes =
      await fileEncryptor.decryptRecordingToMemory(encryptedFilePath);
      print("Decrypted audio loaded into memory");

      final BytesSource bytesSource = BytesSource(decryptedAudioBytes);
      isPlayingPlayback.value = true;

      await _audioPlayer.play(bytesSource);
    } catch (e) {
      print("Error playing test audio: $e");
    }
  }

  void playAudioFromTask() {}
}
