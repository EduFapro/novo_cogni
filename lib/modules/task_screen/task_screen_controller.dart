import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluation/evaluation_repository.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/participant/participant_entity.dart';
import '../../app/recording_file/recording_file_entity.dart';
import '../../app/recording_file/recording_file_repository.dart';
import '../../app/task/task_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../app/task_instance/task_instance_repository.dart';
import '../../constants/enums/module_enums.dart';
import '../../constants/enums/task_enums.dart';
import '../../constants/route_arguments.dart';
import '../../file_management/audio_management.dart';
import '../../file_management/file_encryptor.dart';
import '../evaluation/evaluation_controller.dart';
import '../evaluation/evaluation_service.dart';
import '../home/home_controller.dart';
import 'task_screen_service.dart';

class TaskScreenController extends GetxController {
  final EvaluationService evaluationService = Get.find();

  final TaskScreenService taskService;
  late final AudioPlayer _audioPlayer;
  late final AudioRecorder _recorder;

  var participant = Rxn<ParticipantEntity>();
  var evaluation = Rxn<EvaluationEntity>();
  var evaluator = Rxn<EvaluatorEntity>();
  var taskName = RxString("");
  var task = Rxn<TaskEntity>();
  var taskInstance = Rxn<TaskInstanceEntity>();
  var moduleInstance = Rxn<ModuleInstanceEntity>();

  var audioPath = ''.obs;
  var imagePath = 'no_image'.obs;
  var displayImage = false;
  var currentTask = Rx<TaskInstanceEntity?>(null);
  var taskMode = Rx<TaskMode>(TaskMode.record);
  var currentTaskEntity = Rx<TaskEntity?>(null);
  var countdownStarted = false.obs;
  var countdownTrigger = false.obs;
  var currentTaskIndex = 1.obs;
  var totalTasks = 1.obs;
  var isModuleCompleted = false.obs;

  var isPlaying = false.obs;
  var audioPlayed = false.obs;
  var isRecording = false.obs;
  var isPlayingPlayback = false.obs;
  var recordingDone = false.obs;
  var isCheckButtonEnabled = false.obs;
  var isRecordButtonEnabled = false.obs;
  var isRecentlyRecordedAudioPlaying = false.obs;
  var recordingDuration = ''.obs;
  var remainingTime = ''.obs;

  Timer? _countdownTimer;

  StreamSubscription<void>? _playerCompleteSubscription;

  RxBool get shouldDisablePlayButton =>
      RxBool(!mayRepeatPrompt.value && promptPlayedOnce.value ||
          isRecording.value ||
          isPlayingPlayback.value);

  RxBool get shouldDisablePlayRecentlyButton =>
      RxBool(isPlaying.value || isRecording.value);

  var mayRepeatPrompt = false.obs;
  var promptPlayedOnce = false.obs;
  var playbackPath = ''.obs;
  var hasPlaybackPath = false.obs;

  var recordingRepository = Get.find<RecordingRepository>();
  var evaluationRepository = Get.find<EvaluationRepository>();
  var taskInstanceRepository = Get.find<TaskInstanceRepository>();

  DateTime? _audioStopTime;
  DateTime? _buttonClickTime;

  TaskScreenController({required this.taskService});

  Future<void> refreshProgress() async {
    final taskInstances =
        await taskInstanceRepository.getTaskInstancesByModuleInstanceId(
            moduleInstance.value!.moduleInstanceID!);
    final completedTasksCount = taskInstances
        .where((taskInst) => taskInst.status == TaskStatus.done)
        .length;
    currentTaskIndex.value = completedTasksCount + 1;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      participant.value = arguments[RouteArguments.PARTICIPANT];
      evaluation.value = arguments[RouteArguments.EVALUATION];
      evaluator.value = arguments[RouteArguments.EVALUATOR];

      taskName.value = arguments[RouteArguments.TASK_NAME];
      task.value = arguments[RouteArguments.TASK];
      mayRepeatPrompt.value = task.value!.mayRepeatPrompt;

      taskInstance.value = arguments[RouteArguments.TASK_INSTANCE];

      moduleInstance.value = arguments[RouteArguments.MODULE_INSTANCE];
      if (moduleInstance.value!.moduleInstanceID! != null) {
        await _calculateTotalTasks(moduleInstance.value!.moduleInstanceID!);
      } else {
        print("Module instance ID not found in arguments.");
      }
    }

    if (taskInstance.value != null) {
      await updateCurrentTask(taskInstance.value!.taskInstanceID!);
    } else {
      print("Task instance ID not found in arguments.");
    }

    _audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      audioPlayed.value = true;
      promptPlayedOnce.value = true;
      updateButtonStatesAfterAudioCompletion();
      countdownTrigger.value = true;
    });

    taskMode.listen((mode) {
      print("Task mode changed to: $mode");
    });

    refreshProgress();
  }

  void nextTask() {
    if (currentTaskIndex.value < totalTasks.value - 1) {
      currentTaskIndex.value++;
    }
  }

  Future<Uint8List> loadAudioAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void startCountdown() {
    countdownStarted.value = true;
    Future.delayed(Duration(seconds: 5), () {
      isCheckButtonEnabled.value = true;
    });
  }

  Future<void> updateCurrentTask(int taskInstanceId) async {
    try {
      var taskInstance = await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        currentTask.value = taskInstance;
        var taskEntity = await taskService.getTask(taskInstance.taskID);
        currentTaskEntity.value = taskEntity;

        mayRepeatPrompt.value = taskEntity?.mayRepeatPrompt ?? false;
        taskMode.value = taskEntity?.taskMode ?? TaskMode.play;

        isCheckButtonEnabled.value = false;
        isRecordButtonEnabled.value = false;
        audioPlayed.value = false;
        countdownStarted.value = false;
        countdownTrigger.value = false;
        promptPlayedOnce.value = false;

        var taskPrompt = await taskService
            .getTaskPromptByTaskInstanceID(taskInstance.taskID);
        audioPath.value =
            taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';

        imagePath.value = taskEntity!.imagePath!;
        checkAndDisablePlayButton();
      }
    } catch (e) {
      print("Error updating current task: $e");
    }
    isRecordButtonEnabled.value = false;
    isCheckButtonEnabled.value = false;
    audioPlayed.value = false;
    recordingDone.value = false;
  }

  Future<void> togglePlay() async {
    if (!isPlaying.value) {
      await play();
    } else {
      await stop();
    }
  }

  Future<void> play() async {
    try {
      final Uint8List audioBytes = await loadAudioAsset(audioPath.value);
      final BytesSource bytesSource = BytesSource(audioBytes);
      await _audioPlayer.play(bytesSource);
      isPlaying.value = true;
      isRecordButtonEnabled.value = false;

      _audioPlayer.onPlayerComplete.listen((_) {
        isPlaying.value = false;
        if (shouldEnableRecording()) {
          isRecordButtonEnabled.value = true;
        }
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    audioPlayed.value = true;
    _audioStopTime = DateTime.now();
    countdownTrigger.value = true;
    if (promptPlayedOnce.isTrue) {
      isRecordButtonEnabled.value = true;
    }
  }

  Future<void> startRecording() async {
    shouldDisablePlayButton.value = true;
    bool hasPermission = await _recorder.hasPermission();
    if (hasPermission) {
      String recordingPath = await _getRecordingPath();
      var config = RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      );
      await _recorder.start(config, path: recordingPath);
      isRecording.value = true;
    }
  }

  Future<void> stopRecording() async {
    final String? originalPath = await _recorder.stop();
    isRecording.value = false;

    if (originalPath != null) {
      recordingDone.value = true;

      final evaluationController = Get.find<EvaluationController>();
      final evaluatorID =
          evaluationController.evaluation.value?.evaluatorID ?? 0;
      final participantID =
          evaluationController.participant.value?.participantID ?? 0;
      countdownTrigger.value = false;

      final encryptedFilePath = await renameAndSaveRecording(
        originalPath: originalPath,
        evaluatorId: evaluatorID,
        participantId: participantID,
        taskEntityId: currentTaskEntity.value!.taskID!,
        taskInstanceId: currentTask.value!.taskInstanceID!,
        saveRecordingCallback: (RecordingFileEntity recording) async {
          final recordingId =
              await recordingRepository.createRecording(recording);
          print(
              'Recording saved with ID: $recordingId at path: $recording.filePath');
        },
      );

      playbackPath.value = encryptedFilePath;
      hasPlaybackPath.value = true;

      await decryptAndCalculateDuration(encryptedFilePath);

      if (taskMode.value == TaskMode.record && audioPlayed.value) {
        isCheckButtonEnabled.value = true;
      }
    }
    shouldDisablePlayButton.value = false;
  }

  Future<String> _getRecordingPath() async {
    final String dirPath = await getApplicationDocumentsPath();
    final Directory mySubDir = Directory(path.join(dirPath, 'Cognivoice'));
    if (!await mySubDir.exists()) {
      await mySubDir.create(recursive: true);
    }
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String fileName = 'recording_$timestamp.aac';
    final String filePath = path.join(mySubDir.path, fileName);
    return filePath;
  }

  Future<void> onCheckButtonPressed() async {
    if (currentTask.value != null) {
      await concludeTaskInstance(currentTask.value!.taskInstanceID!);

      if (currentTaskIndex.value < totalTasks.value) {
        currentTaskIndex.value++;
        var nextTaskInstance =
            await evaluationService.getNextPendingTaskInstanceForModule(
                moduleInstance.value!.moduleInstanceID!);
        if (nextTaskInstance != null) {
          await updateCurrentTask(nextTaskInstance.taskInstanceID!);
        } else {
          isModuleCompleted.value = true;
          await setModuleInstanceAsCompleted(
              moduleInstance.value!.moduleInstanceID!);
        }
      } else {
        isModuleCompleted.value = true;
        await setModuleInstanceAsCompleted(
            moduleInstance.value!.moduleInstanceID!);
      }
    } else {
      print("Error: No current task found.");
    }
  }

  Future<void> concludeTaskInstance(int taskInstanceId) async {
    playbackPath.value = '';
    hasPlaybackPath.value = false;
    try {
      TaskInstanceEntity? taskInstance =
          await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        taskInstance.status = TaskStatus.done;
        if (recordingDuration.value.isEmpty) {
          await decryptAndCalculateDuration(playbackPath.value);
        }

        if (currentTaskEntity.value!.taskMode == TaskMode.play) {
          taskInstance.completeTask("Tarefa sem gravação");
        }
        else if (recordingDuration.value == '') {
          taskInstance.completeTask("Pulou a tarefa");
        } else {
          taskInstance.completeTask(recordingDuration.value);
        }
        bool updated = await taskService.updateTaskInstance(taskInstance);
        if (!updated) {
          print('Error updating task instance');
        }
      } else {
        print('Task instance not found');
      }
    } catch (e) {
      print('Error in concludeTaskInstance: $e');
    }
  }

  void completeTask(TaskInstanceEntity taskInstance) async {
    taskInstance.completeTask(recordingDuration.value);
    await taskService.updateTaskInstance(taskInstance);

    final currentTaskEntity = await taskService.getTask(taskInstance.taskID);
    if (currentTaskEntity != null) {
      currentTaskIndex.value = currentTaskEntity.position;
    }
  }

  Future<void> launchNextTask() async {
    if (currentTaskIndex.value >= totalTasks.value) {
      isModuleCompleted.value = true;
    } else if (currentTask.value != null &&
        currentTaskIndex.value < totalTasks.value) {
      await concludeTaskInstance(currentTask.value!.taskInstanceID!);

      final nextTaskInstance =
          await evaluationService.getNextPendingTaskInstanceForModule(
              moduleInstance.value!.moduleInstanceID!);
      if (nextTaskInstance != null) {
        currentTask.value = nextTaskInstance;
        var taskEntity = await taskService.getTask(nextTaskInstance.taskID);
        if (taskEntity != null) {
          currentTaskEntity.value = taskEntity;
          taskMode.value = taskEntity.taskMode;

          var taskPrompt = await taskService
              .getTaskPromptByTaskInstanceID(nextTaskInstance.taskID);
          audioPath.value =
              taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';
          playbackPath.value = '';
          hasPlaybackPath.value = false;

          audioPlayed.value = false;
          isPlaying.value = false;
          if (isRecording.value) {
            await stopRecording();
          }
        }
      } else {
        isModuleCompleted.value = true;
      }
    }
  }

  void checkAndDisablePlayButton() {
    shouldDisablePlayButton.value =
        !mayRepeatPrompt.value && promptPlayedOnce.value;
  }

  void resetProgress() {
    currentTaskIndex.value = 0;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    _playerCompleteSubscription?.cancel();
    _countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> _calculateTotalTasks(int moduleInstanceId) async {
    final taskInstances =
        await taskService.getTasksByModuleInstanceId(moduleInstanceId);
    totalTasks.value = taskInstances.length;
  }

  Future<void> setModuleInstanceAsCompleted(int moduleInstanceId) async {
    await evaluationService.setModuleInstanceAsCompleted(moduleInstanceId);
    var evaluationID =
        Get.find<EvaluationController>().evaluation.value!.evaluationID!;
    bool allModulesCompleted =
        await evaluationService.areAllModulesCompleted(evaluationID);
    if (allModulesCompleted) {
      print("All modules completed. Evaluation can be marked as completed.");
      evaluationRepository.setEvaluationAsCompleted(evaluationID);
      Get.find<HomeController>().refreshEvaluations();
      Get.find<HomeController>().refreshEvaluationCounts();
      Get.find<EvaluationController>().refreshModuleCompletionStatus(
          moduleInstanceId, ModuleStatus.completed);
    }
  }

  Future<void> skipCurrentTask() async {
    if (currentTask.value != null) {
      if (isPlaying.value) {
        await stop();
      }

      if (isRecording.value) {
        await stopRecording();
      }

      await concludeTaskInstance(currentTask.value!.taskInstanceID!);

      if (currentTaskIndex.value < totalTasks.value) {
        currentTaskIndex.value++;
        var nextTaskInstance =
            await evaluationService.getNextPendingTaskInstanceForModule(
                moduleInstance.value!.moduleInstanceID!);
        if (nextTaskInstance != null) {
          await updateCurrentTask(nextTaskInstance.taskInstanceID!);
        } else {
          isModuleCompleted.value = true;
          await setModuleInstanceAsCompleted(
              moduleInstance.value!.moduleInstanceID!);
        }
      } else {
        isModuleCompleted.value = true;
        await setModuleInstanceAsCompleted(
            moduleInstance.value!.moduleInstanceID!);
      }
    } else {
      print("Error: No current task found.");
    }
  }

  void manageButtonStates(
      {required bool isAudioPlaying, required bool isAudioCompleted}) {
    if (isAudioPlaying) {
      isCheckButtonEnabled.value = false;
    }

    if (isAudioCompleted) {
      startCountdown();
    }
  }

  bool shouldEnableRecording() {
    return taskMode.value == TaskMode.record &&
        !isPlaying.value &&
        promptPlayedOnce.value;
  }

  void updateButtonStatesAfterAudioCompletion() {
    if (taskMode.value == TaskMode.play) {
      isCheckButtonEnabled.value = true;
    } else if (taskMode.value == TaskMode.record && recordingDone.value) {
      isCheckButtonEnabled.value = true;
    }

    if (taskMode.value == TaskMode.record) {
      isRecordButtonEnabled.value = true;
    }
  }

  Future<void> playRecentlyRecorded() async {
    print("HOHOHOHUHO");
    print(playbackPath.value);
    final String encryptedFilePath = playbackPath.value;

    final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
    try {
      final Uint8List decryptedAudioBytes =
          await fileEncryptor.decryptRecordingToMemory(encryptedFilePath);
      print("Decrypted audio loaded into memory");

      final BytesSource bytesSource = BytesSource(decryptedAudioBytes);
      isPlayingPlayback.value = true;
      remainingTime.value = recordingDuration.value;

      await _audioPlayer.play(bytesSource);
      isRecentlyRecordedAudioPlaying.value = true;

      _startCountdownTimer();

      _playerCompleteSubscription =
          _audioPlayer.onPlayerComplete.listen((_) async {
        isPlayingPlayback.value = false;
        isRecentlyRecordedAudioPlaying.value = false;

        _countdownTimer?.cancel();

        print("Playback completed");
        _playerCompleteSubscription?.cancel();
        _playerCompleteSubscription = null;
      });
    } catch (e) {
      print("Error playing test audio: $e");
    }
  }

  Future<void> stopRecentlyRecorded() async {
    try {
      await _audioPlayer.stop();
      isPlayingPlayback.value = false;
      isRecentlyRecordedAudioPlaying.value = false;

      _countdownTimer?.cancel();
      remainingTime.value = recordingDuration.value;

      _playerCompleteSubscription?.cancel();
      _playerCompleteSubscription = null;
    } catch (e) {
      print("Error stopping playback: $e");
    }
  }

  Future<void> decryptAndCalculateDuration(String filePath) async {
    final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();

    try {
      final Uint8List decryptedAudioBytes =
          await fileEncryptor.decryptRecordingToMemory(filePath);

      await _audioPlayer.setSourceBytes(decryptedAudioBytes);
      final duration = await _audioPlayer.getDuration();
      final minutes = duration?.inMinutes ?? 0;
      final seconds = (duration?.inSeconds ?? 0) % 60;

      recordingDuration.value =
          '$minutes:${seconds.toString().padLeft(2, '0')}';

      remainingTime.value = recordingDuration.value;

      print("Audio Duration: $recordingDuration");
    } catch (e) {
      print("Error decrypting and calculating duration: $e");
    }
  }

  void _startCountdownTimer() {
    final parts = recordingDuration.value.split(':');
    int totalSeconds = int.parse(parts[0]) * 60 + int.parse(parts[1]);

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        final minutes = totalSeconds ~/ 60;
        final seconds = totalSeconds % 60;
        remainingTime.value = '$minutes:${seconds.toString().padLeft(2, '0')}';
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> discardRecording() async {
    playbackPath.value = '';
    hasPlaybackPath.value = false;
    recordingDuration.value = '';
    isCheckButtonEnabled.value = false;
    isRecordButtonEnabled.value = true;
    remainingTime.value = '';

    if (_countdownTimer != null) {
      _countdownTimer!.cancel();
    }
  }
}
