import 'dart:io';

import 'package:get/get.dart';
import 'package:novo_cogni/app/recording_file/recording_file_repository.dart';
import 'package:novo_cogni/constants/enums/language_enums.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/module_instance/module_instance_repository.dart';
import '../../app/participant/participant_entity.dart';
import '../../../constants/enums/module_enums.dart';
import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/recording_file/recording_file_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../app/task_instance/task_instance_repository.dart';
import '../../file_management/evaluation_download.dart';
import '../../file_management/file_encryptor.dart';
import '../../global/user_controller.dart';
import 'package:path/path.dart' as path;

import '../eval_data/eval_data_service.dart';

class HomeController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
  var isLoading = false.obs;
  var user = Rxn<EvaluatorEntity>();
  var evaluations = RxList<EvaluationEntity>();
  var participants = RxList<ParticipantEntity>();
  var participantDetails = RxMap<int, ParticipantEntity>();

  var numEvaluationsInProgress = 0.obs;
  var numEvaluationsFinished = 0.obs;
  var numEvaluationsTotal = 0.obs;

  var moduleInstanceRepository = Get.find<ModuleInstanceRepository>();
  var taskInstanceRepository = Get.find<TaskInstanceRepository>();
  var recordingRepository = Get.find<RecordingRepository>();
  var evalDataService = Get.find<EvalDataService>();

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    setupListeners();
    fetchData();
    numEvaluationsTotal.value = evaluations.length;
  }

  void setupListeners() {
    listenToUserChanges();
    listenToEvaluationsChanges();
    listenToParticipantsChanges();
    listenToParticipantDetailsChanges();
  }

  void listenToUserChanges() {
    ever(userController.user, (EvaluatorEntity? newUser) {
      user.value = newUser;
      print("User updated: ${user.value?.name}");
    });
  }

  void listenToEvaluationsChanges() {
    ever(userController.evaluations, (List<EvaluationEntity> newEvaluations) {
      evaluations.assignAll(newEvaluations);
      isLoading.value = newEvaluations.isNotEmpty;
      print("Evaluations updated: ${evaluations.length}");

      // Reset counters
      numEvaluationsInProgress.value = 0;
      numEvaluationsFinished.value = 0;
      numEvaluationsTotal.value = newEvaluations.length;

      // Update counters based on the status of each evaluation
      for (var evaluation in newEvaluations) {
        if (evaluation.status == ModuleStatus.in_progress) {
          numEvaluationsInProgress.value++;
        } else if (evaluation.status == ModuleStatus.completed) {
          numEvaluationsFinished.value++;
        }
      }
    });
  }

  void listenToParticipantsChanges() {
    ever(userController.participants,
        (List<ParticipantEntity> newParticipants) {
      participants.assignAll(newParticipants);
      print("Participants updated: ${participants.length}");
    });
  }

  void listenToParticipantDetailsChanges() {
    ever(userController.participantDetails,
        (Map<int, ParticipantEntity> newDetails) {
      participantDetails.assignAll(newDetails);
      print("Participant details updated");
    });
  }

  void fetchData() async {
    isLoading.value = true;
    await userController.fetchUserData();
    var currentUser = await userController.getCurrentUserOrFetch();
    if (currentUser != null) {
      user.value = currentUser;
    }
    updateLoadingState();
  }

  void updateLoadingState() {
    isLoading.value = !(user.value != null &&
        evaluations.isNotEmpty &&
        participants.isNotEmpty);
  }

  void addNewParticipant(ParticipantEntity newParticipant,
      Map<String, int> newParticipantMap, Language language) {
    var newParticipantID = newParticipantMap["participantId"];
    var newEvaluationID = newParticipantMap["evaluationId"];
    var evaluatorID = user.value!.evaluatorID;
    print("newParticipantID: $newParticipantID");
    print("newEvaluationID: $newEvaluationID");
    print("EvaluatorID: $evaluatorID");

    participants.add(newParticipant);
    participantDetails[newParticipantID!] = newParticipant;

    evaluations.add(EvaluationEntity(
        evaluatorID: evaluatorID!,
        evaluationID: newEvaluationID,
        participantID: newParticipantID,
        language: language.numericValue));

    // Refresh data to update UI and other dependent components
    // refreshData();
  }

  void refreshData() async {
    // Await the completion of fetchData()
    fetchData();
  }

  Future<void> handleDownload(
      int evaluationId, String evaluatorId, String participantId) async {
    // 1. Fetch all task instances related to the evaluation
    List<TaskInstanceEntity> taskInstances =
        await fetchTaskInstancesForEvaluation(evaluationId);

    // 2. Fetch all recordings for these task instances
    List<RecordingFileEntity> recordings = [];
    for (var taskInstance in taskInstances) {
      List<RecordingFileEntity> taskRecordings = await recordingRepository
          .getRecordingsByTaskInstanceId(taskInstance.taskInstanceID!);
      recordings.addAll(taskRecordings);
    }

    // 3. Create the folder in the downloads directory
    String downloadFolderPath =
        await createDownloadFolder(evaluatorId, participantId);

    // 4. Copy the audio files to the new folder
    // Decrypt files and rename them back to .aac
    for (var recording in recordings) {
      String encryptedFilePath = recording.filePath;
      String fileNameWithoutExtension = path.basenameWithoutExtension(encryptedFilePath);
      String decryptedFilePath = path.join(downloadFolderPath, "$fileNameWithoutExtension");

      // Decrypt the file back to its original form
      await fileEncryptor.decryptFile(encryptedFilePath, decryptedFilePath);

      print('Decrypted recording saved at path: $decryptedFilePath');
    }
  }

  Future<void> createDownload(EvaluationEntity evaluation) async {

    final downloadFolderPath = await createDownloadFolder(
        evaluation.evaluatorID.toString(), evaluation.participantID.toString());

    generateParticipantRecordFile(
        evaluation: evaluation, filePath: downloadFolderPath);


  }

  Future<List<TaskInstanceEntity>> fetchTaskInstancesForEvaluation(
      int evaluationId) async {
    List<TaskInstanceEntity> allTaskInstances = [];

    // Get Module Instances by Evaluation ID
    List<ModuleInstanceEntity> moduleInstances = await moduleInstanceRepository
        .getModuleInstancesByEvaluationId(evaluationId);

    // Get Task Instances for each Module Instance
    for (var moduleInstance in moduleInstances) {
      List<TaskInstanceEntity> taskInstances = await taskInstanceRepository
          .getTaskInstancesByModuleInstanceId(moduleInstance.moduleInstanceID!);
      allTaskInstances.addAll(taskInstances);
    }

    return allTaskInstances;
  }

  void generateParticipantRecordFile(
      {required EvaluationEntity evaluation, required String filePath}) {
    evalDataService.generateParticipantRecordFile(
        evaluation: evaluation, filePath: filePath);
  }
}
