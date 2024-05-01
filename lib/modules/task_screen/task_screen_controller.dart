import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:novo_cogni/app/evaluation/evaluation_repository.dart';
import 'package:novo_cogni/app/evaluator/evaluator_entity.dart';
import 'package:novo_cogni/app/module_instance/module_instance_entity.dart';
import 'package:novo_cogni/app/recording_file/recording_file_repository.dart';
import 'package:novo_cogni/app/task_instance/task_instance_repository.dart';
import 'package:novo_cogni/constants/route_arguments.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import '../../app/evaluation/evaluation_entity.dart';
import '../../app/participant/participant_entity.dart';
import '../../app/recording_file/recording_file_entity.dart';
import '../../app/task/task_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../constants/enums/module_enums.dart';
import '../../constants/enums/task_enums.dart';
import '../../file_management/audio_management.dart';
import '../../file_management/file_encryptor.dart';
import '../evaluation/evaluation_controller.dart';
import '../evaluation/evaluation_service.dart';
import 'task_screen_service.dart';

class TaskScreenController extends GetxController {
  final EvaluationService evaluationService = Get.find();
  final ScrollController scrollController = ScrollController();
  final TaskScreenService taskService;
  late final AudioPlayer _audioPlayer;
  late final AudioRecorder _recorder;

  var participant = Rxn<ParticipantEntity>();
  var evaluation = Rxn<EvaluationEntity>();
  var evaluator = Rxn<EvaluatorEntity>();
  var moduleInstance = Rxn<ModuleInstanceEntity>();

  var taskName = RxString("");
  var currentTaskEntity = Rxn<TaskEntity>();
  var currentTaskIndex = 1.obs;
  var totalTasks = 1.obs;
  var mayRepeatPrompt = false.obs;
  var audioPath = ''.obs;
  var imagePath = ''.obs;
  var currentTaskInstance = Rxn<TaskInstanceEntity>();
  var taskMode = Rx<TaskMode>(TaskMode.record);

  var countdownStarted = false.obs;
  var countdownTrigger = false.obs;
  var isModuleCompleted = false.obs;

  var isPlaying = false.obs;
  var audioPlayed = false.obs;
  var isRecording = false.obs;
  var recordingDone = false.obs;
  var isCheckButtonEnabled = false.obs;
  var isRecordButtonEnabled = false.obs;
  var isRecordButtonPlaying = false.obs;

  // MÓDULO DE TESTE
  var isTestOnly = false.obs;
  var isTestingRecordButtonPlaying = false.obs;
  var isTestingRecordButtonEnabled = false.obs;

  var isTestingPlaybackButtonPlaying = false.obs;
  var isTestingPlaybackButtonEnabled = false.obs;
  var playbackPath = ''.obs;

  // Inside TaskScreenController
  RxBool get shouldDisablePlayButton => RxBool(
      !mayRepeatPrompt.value && promptPlayedOnce.value || isRecording.value);

  var promptPlayedOnce = false.obs;

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
    isTestingRecordButtonEnabled.value =
        false; // Ensure testing button is disabled initially
    isRecordButtonEnabled.value =
        false; // Regular recording button disabled initially

    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      participant.value = arguments[RouteArguments.PARTICIPANT];
      evaluation.value = arguments[RouteArguments.EVALUATION];
      evaluator.value = arguments[RouteArguments.EVALUATOR];

      taskName.value = arguments[RouteArguments.TASK_NAME];
      currentTaskEntity.value = arguments[RouteArguments.TASK];
      mayRepeatPrompt.value = currentTaskEntity.value!.mayRepeatPrompt;

      currentTaskInstance.value = arguments[RouteArguments.TASK_INSTANCE];
      isTestOnly.value = currentTaskEntity.value!.testOnly;
      moduleInstance.value = arguments[RouteArguments.MODULE_INSTANCE];
      if (moduleInstance.value!.moduleInstanceID! != null) {
        // Calculate total tasks for the module instance.
        await _calculateTotalTasks(moduleInstance.value!.moduleInstanceID!);
      } else {
        // Fallback or error handling if moduleInstanceId is not provided.
        print("Module instance ID not found in arguments.");
      }
    }
    // Update the current task based on the task instance ID passed in the arguments.
    if (currentTaskInstance.value != null) {
      await updateCurrentTask(currentTaskInstance.value!.taskInstanceID!);
    } else {
      // Fallback or error handling if task instance ID is not provided.
      print("Task instance ID not found in arguments.");
    }

    _audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      audioPlayed.value = true;
      promptPlayedOnce.value = true;

      // Enable buttons as needed after audio completion
      updateButtonStatesAfterAudioCompletion();

      // Trigger countdown as audio has finished playing
      countdownTrigger.value = true; // This will start the countdown
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      audioPlayed.value = true;
      promptPlayedOnce.value = true;

      // Now scroll after audio completes
      scrollToPosition(500.0); // Adjust the scroll position as needed

      updateButtonStatesAfterAudioCompletion();
      countdownTrigger.value = true; // Start countdown
    });

    taskMode.listen((mode) {
      print("Task mode changed to: $mode");
    });

    refreshProgress();
  }

  // Function to proceed to the next task
  void nextTask() {
    if (currentTaskIndex.value < totalTasks.value - 1) {
      currentTaskIndex.value++;
      // Load the next task or handle it accordingly
    }
  }

  Future<Uint8List> loadAudioAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void startCountdown() {
    countdownStarted.value = true;

    // Simulate countdown using Future.delayed
    Future.delayed(Duration(seconds: 5), () {
      // Countdown completed
      isCheckButtonEnabled.value = true;
    });
  }

  Future<void> updateCurrentTask(int taskInstanceId) async {
    try {
      var taskInstance = await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        currentTaskInstance.value = taskInstance;
        var taskEntity = await taskService.getTask(taskInstance.taskID);

        if (taskEntity != null) {
          currentTaskEntity.value = taskEntity;

          // Update task name based on the current task's details
          taskName.value = taskEntity.title;
          print(currentTaskEntity.value);

          // Update mayRepeatPrompt based on the current task's properties
          mayRepeatPrompt.value = taskEntity.mayRepeatPrompt ?? false;
          print("IS TEST ONLY AAAA: ${taskEntity.testOnly}");
          // Update the task mode
          taskMode.value = taskEntity.taskMode ?? TaskMode.play;

          isTestOnly.value = taskEntity.testOnly ?? false;

          // Fetch and set the audio path for the current task
          var taskPrompt = await taskService
              .getTaskPromptByTaskInstanceID(taskInstance.taskID);
          audioPath.value =
              taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';

          print("image path: ${taskEntity.imagePath}");
          // Update the image path if there is one
          imagePath.value = taskEntity.imagePath ??
              ''; // Assuming `imagePath` is a property of TaskEntity
          print("hahaah" + imagePath.value);
          // Reset states for the new task
          isCheckButtonEnabled.value = false;
          isRecordButtonEnabled.value = false;
          audioPlayed.value = false;
          countdownStarted.value = false;
          countdownTrigger.value = false;
          promptPlayedOnce.value = false;

          // Ensure appropriate button states
          checkAndDisablePlayButton();
        } else {
          print('Task entity not found');
        }
      } else {
        print('Task instance not found');
      }
    } catch (e) {
      print("Error updating current task: $e");
    }
    // Reset flags related to task progression
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
        audioPlayed.value = true;
        promptPlayedOnce.value = true;

        // Check the mode to decide enabling the record button
        if (isTestOnly.value) {
          isTestingRecordButtonEnabled.value =
              true; // Enable the testing record button
        } else {
          // Only enable recording if all conditions for recording are met
          if (shouldEnableRecording()) {
            isRecordButtonEnabled.value = true;
          }
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

    // Start countdown after audio stops
    countdownTrigger.value = true;
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

      // isRecordButtonEnabled.value = false;
    } else {
      // Handle permission not granted
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

      // Encrypt the recording, rename it and save the new path
      final encryptedFilePath = await renameAndSaveRecording(
        originalPath: originalPath,
        evaluatorId: evaluatorID,
        participantId: participantID,
        taskEntityId: currentTaskEntity.value!.taskID!,
        taskInstanceId: currentTaskInstance.value!.taskInstanceID!,
        saveRecordingCallback: (RecordingFileEntity recording) async {
          final recordingId =
              await recordingRepository.createRecording(recording);
          print(
              'Recording saved with ID: $recordingId at path: $recording.filePath');
        },
      );

      // Update the observable path with the encrypted file's path
      audioPath.value = encryptedFilePath;

      // In TaskMode.record, enable check button if audio has been played.
      if (taskMode.value == TaskMode.record && audioPlayed.value) {
        isCheckButtonEnabled.value = true;
      }
    } else {
      print('Recording was not stopped properly or path was null');
    }
    shouldDisablePlayButton.value = false;
  }

  // Future<void> saveAudio(ByteData data) async {
  //   print('saveAudio called');
  //   var evaluationController = Get.find<EvaluationController>();
  //   var evaluatorID = evaluationController.evaluation.value?.evaluatorID;
  //   var participantID = evaluationController.participant.value?.participantID;
  //
  //   if (evaluatorID != null && participantID != null) {
  //     print(
  //         'Saving audio for evaluator: $evaluatorID, participant: $participantID');
  //     // Create a unique file name for the temporary file
  //     final tempFileName = 'temp_recording.aac';
  //
  //     // Save the temporary file
  //     String tempPath = await saveAudioFile(data, tempFileName, evaluatorID,
  //         participantID, currentTask.value!.taskInstanceID!);
  //
  //     // Update audioPath to the new path
  //     audioPath.value = tempPath;
  //   } else {
  //     print('Evaluator ID or Participant ID is null');
  //     // Handle the null case, perhaps by using a default name or notifying the user
  //   }
  // }

  Future<String> _getRecordingPath() async {
    // Obtain the directory path for the application's documents directory.
    final String dirPath = await getApplicationDocumentsPath();

    // Create a Directory object using the documents directory path and appending the 'Cognivoice' subdirectory.
    final Directory mySubDir = Directory(path.join(dirPath, 'Cognivoice'));

    // Check if the 'Cognivoice' directory exists, and if not, create it recursively.
    if (!await mySubDir.exists()) {
      await mySubDir.create(recursive: true);
    }

    // Generate a timestamp string based on the current date and time for use in the file name.
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Construct a file name using the evaluator and participant ID, along with the timestamp, to ensure uniqueness.
    final String fileName = 'recording_$timestamp.aac';

    // Use the path package's join method to concatenate the directory path and file name,
    // ensuring the correct path separators are used for the platform.
    final String filePath = path.join(mySubDir.path, fileName);

    // Return the full file path where the recording will be saved.
    return filePath;
  }

  Future<void> onCheckButtonPressed() async {
    await proceedToNextTask();
  }

  Future<void> concludeTaskInstance(int taskInstanceId) async {
    try {
      TaskInstanceEntity? taskInstance =
          await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        taskInstance.status = TaskStatus.done;
        if (_audioStopTime != null) {
          final duration = DateTime.now().difference(_audioStopTime!);
          taskInstance.completeTask(duration);
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
    // Logic to mark the task as completed.
    taskInstance.completeTask(Duration.zero);
    await taskService.updateTaskInstance(taskInstance);

    // Assuming that the position in TaskEntity is the order of the task.
    final currentTaskEntity = await taskService.getTask(taskInstance.taskID);
    if (currentTaskEntity != null) {
      currentTaskIndex.value = currentTaskEntity.position;
    }
    // Load the next task or conclude if all tasks are completed.
  }

  Future<void> launchNextTask() async {
    if (currentTaskIndex.value >= totalTasks.value) {
      // All tasks are completed
      isModuleCompleted.value = true;
    } else if (currentTaskInstance.value != null &&
        currentTaskIndex.value < totalTasks.value) {
      await concludeTaskInstance(currentTaskInstance.value!.taskInstanceID!);

      // Fetch the next pending task instance
      final nextTaskInstance =
          await evaluationService.getNextPendingTaskInstanceForModule(
              moduleInstance.value!.moduleInstanceID!);
      if (nextTaskInstance != null) {
        // Update the current task
        currentTaskInstance.value = nextTaskInstance;
        // Fetch task entity for the next task
        var taskEntity = await taskService.getTask(nextTaskInstance.taskID);
        if (taskEntity != null) {
          currentTaskEntity.value = taskEntity;
          taskMode.value = taskEntity.taskMode;

          // Fetch and set the audio path for the next task
          var taskPrompt = await taskService
              .getTaskPromptByTaskInstanceID(nextTaskInstance.taskID);
          audioPath.value =
              taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';

          // Reset audio player and recording states
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
    super.onClose();
  }

  Future<void> _calculateTotalTasks(int moduleInstanceId) async {
    final taskInstances =
        await taskService.getTasksByModuleInstanceId(moduleInstanceId);
    totalTasks.value = taskInstances.length;
  }

  Future<void> setModuleInstanceAsCompleted(int moduleInstanceId) async {
    await evaluationService.setModuleInstanceAsCompleted(moduleInstanceId);
    final evalController = Get.find<EvaluationController>();
    // evalController.markModuleAsCompleted(
    //     controller.moduleInstance.value!.moduleInstanceID!);
    evalController.updateModuleInstanceInList(
        moduleInstance.value!.moduleInstanceID!, ModuleStatus.in_progress);
    var evaluationID = evalController.evaluation.value!.evaluationID!;
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
    await proceedToNextTask();
  }

  void manageButtonStates(
      {required bool isAudioPlaying, required bool isAudioCompleted}) {
    if (isAudioPlaying) {
      // Disable the check button while audio is playing
      isCheckButtonEnabled.value = false;
    }

    if (isAudioCompleted) {
      startCountdown();
    }
  }

  bool shouldEnableRecording() {
    // Add your conditions here. Example:
    return taskMode.value == TaskMode.record &&
        !isPlaying.value &&
        promptPlayedOnce.value;
  }

  void updateButtonStatesAfterAudioCompletion() {
    // Check button should be enabled only if no recording is needed or after recording is completed.
    // In TaskMode.play, enable if audio has played. In TaskMode.record, defer until recording is done.
    if (taskMode.value == TaskMode.play) {
      isCheckButtonEnabled.value = true;
    } else if (taskMode.value == TaskMode.record && recordingDone.value) {
      isCheckButtonEnabled.value = true;
    }

    // Ensure record button is enabled only in record mode and after audio playback.
    if (taskMode.value == TaskMode.record) {
      isRecordButtonEnabled.value = true;
    }
  }

  Future<void> proceedToNextTask() async {
    if (currentTaskInstance.value != null) {
      // Stop any ongoing audio or recording
      if (isPlaying.value) {
        await stop();
      }

      if (isRecording.value) {
        await stopRecording();
      }

      await concludeTaskInstance(currentTaskInstance.value!.taskInstanceID!);

      // Transition to the next task or mark the module as completed
      if (currentTaskIndex.value < totalTasks.value) {
        currentTaskIndex.value++; // Move to the next task

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

  // Future<void> stopTestingRecording() async {
  //   final String? originalPath = await _recorder.stop();
  //   isRecording.value = false;
  //
  //   if (originalPath != null) {
  //     recordingDone.value = true;
  //
  //     // Encrypt the recording and save it in the 'testing' folder
  //     final encryptedFilePath = await renameAndSaveTestingRecording(
  //       originalPath: originalPath,
  //       taskInstanceId: currentTaskInstance.value!.taskInstanceID!,
  //       saveRecordingCallback: (RecordingFileEntity recording) async {
  //         final recordingId =
  //             await recordingRepository.createRecording(recording);
  //         print(
  //             'Testing recording saved with ID: $recordingId at path: $recording.filePath');
  //       },
  //     );
  //
  //     // Update the observable path with the encrypted file's path
  //     audioPath.value = encryptedFilePath;
  //
  //     // Here we ensure that after stopping the recording,
  //     // isTestingRecordButtonEnabled is set to true for further actions.
  //     isTestingRecordButtonEnabled.value = true;
  //   } else {
  //     print('Recording was not stopped properly or path was null');
  //   }
  // }

  // Future<void> playTest() async {
  //   final String encryptedFilePath = audioPath.value;
  //   try {
  //     final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
  //
  //     // Decrypt the audio file
  //     final String decryptedFilePath =
  //         await fileEncryptor.decryptRecording(encryptedFilePath);
  //
  //     // Play the decrypted audio file
  //     await _audioPlayer.play(UrlSource(decryptedFilePath),
  //         mode: PlayerMode.lowLatency);
  //     isTestingRecordButtonPlaying.value = true;
  //
  //     // Handle audio completion to clean up the decrypted file
  //     _audioPlayer.onPlayerComplete.listen((_) {
  //       isTestingRecordButtonPlaying.value = false;
  //       File(decryptedFilePath).delete().catchError((e) {
  //         print("Error deleting decrypted file: $e");
  //       });
  //     });
  //   } catch (e) {
  //     print("Error playing test audio: $e");
  //     // Handle errors appropriately
  //   }
  // }

  Future<void> stopPlayingTest() async {
    print("pressed stopPlayingTest");
    await _audioPlayer.stop();
    togglePlayback();

  }
  void togglePlayback() {
    isTestingPlaybackButtonPlaying.value = !isTestingPlaybackButtonPlaying.value;
  }

  // Future<void> stopTestingRecording() async {
  //   final String? originalPath = await _recorder.stop();
  //   isRecording.value = false;
  //
  //   if (originalPath != null) {
  //     recordingDone.value = true;
  //
  //     final encryptedFilePath = await renameAndSaveTestingRecording(
  //       originalPath: originalPath,
  //       taskInstanceId: currentTaskInstance.value!.taskInstanceID!,
  //       saveRecordingCallback: (RecordingFileEntity recording) async {
  //         final recordingId = await recordingRepository.createRecording(recording);
  //         print('Testing recording saved with ID: $recordingId at path: $recording.filePath');
  //       },
  //     );
  //
  //     audioPath.value = encryptedFilePath;  // Update path to the encrypted testing file
  //     isTestingRecordButtonEnabled.value = true;  // Enable playback button
  //   } else {
  //     print('Recording was not stopped properly or path was null');
  //   }
  // }

  // Future<void> playTestRecording() async {
  //   final String encryptedFilePath = audioPath.value;
  //
  //   final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
  //   final String decryptedFilePath = await fileEncryptor.decryptRecording(encryptedFilePath);
  //
  //   await _audioPlayer.play(UrlSource(decryptedFilePath));
  //   isTestingRecordButtonPlaying.value = true;
  //
  //   _audioPlayer.onPlayerComplete.listen((_) {
  //     isTestingRecordButtonPlaying.value = false;
  //     File(decryptedFilePath).delete().catchError((e) {
  //       print("Error deleting decrypted file: $e");
  //     });
  //   });
  // }

  // This is called when the audio playback of the task prompt finishes
  void onPromptPlaybackComplete() {
    if (isTestOnly.isTrue) {
      isTestingRecordButtonEnabled.value =
          true; // Enable recording button only in test mode
    }
  }

  Future<void> stopTestingRecording() async {
    final String? originalPath = await _recorder.stop();
    isRecording.value = false;

    if (originalPath != null) {
      recordingDone.value = true;

      // Assuming you have these IDs available somewhere in your controller
      final int evaluatorId =
          evaluator.value?.evaluatorID ?? 0; // Replace with actual value
      final int participantId =
          participant.value?.participantID ?? 0; // Replace with actual value
      final int taskEntityId =
          currentTaskEntity.value?.taskID ?? 0; // Replace with actual value

      final encryptedFilePath = await renameAndSaveTestingRecording(
        originalPath: originalPath,
        evaluatorId: evaluatorId,
        participantId: participantId,
        taskEntityId: taskEntityId,
        taskInstanceId: currentTaskInstance.value!.taskInstanceID!,
        saveRecordingCallback: (RecordingFileEntity recording) {
          recordingRepository.createRecording(recording);
        },
      );
      print(originalPath);
      print(encryptedFilePath);
      playbackPath.value = encryptedFilePath;
      audioPath.value = encryptedFilePath;
      isTestingPlaybackButtonEnabled.value = true;
    } else {
      print('Recording was not stopped properly or path was null');
    }
  }

  // Call this method when you want to start playback in test mode
  // Call this method when you want to start playback in test mode
  Future<void> playTestRecording() async {
    togglePlayback();
    print("HOHOHOHUHO");
    print(playbackPath.value);
    final String encryptedFilePath =
        playbackPath.value; // Use playbackPath.value
    final FileEncryptor fileEncryptor = Get.find<FileEncryptor>();
    try {
      // Decrypt the recording file before playback
      final String decryptedFilePath =
          await fileEncryptor.decryptRecording(encryptedFilePath);
      print(decryptedFilePath);

      // Read the decrypted file into a byte array
      final Uint8List audioBytes = await File(decryptedFilePath).readAsBytes();

      // Play the decrypted audio file using BytesSource
      final BytesSource bytesSource = BytesSource(audioBytes);
      await _audioPlayer.play(bytesSource);
      isTestingPlaybackButtonPlaying.value = true;

      _audioPlayer.onPlayerComplete.listen((_) {
        isTestingPlaybackButtonPlaying.value = false;
        // Clean up the decrypted file after playback
        File(decryptedFilePath).delete().catchError((error) {
          print("Error deleting decrypted file: $error");
        });
      });
    } catch (e) {
      print("Error playing test audio: $e");
      // Handle errors appropriately
    }
  }

  startTestingRecording() async {
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

      // isRecordButtonEnabled.value = false;
    } else {
      // Handle permission not granted
    }
  }

  void scrollToPosition(double position) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        position,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
