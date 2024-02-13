import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:novo_cogni/constants/route_arguments.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import '../../app/domain/entities/task_entity.dart';
import '../../app/domain/entities/task_instance_entity.dart';
import '../../constants/enums/task_enums.dart';
import '../../file_management/audio_management.dart';
import 'task_service.dart';

class TaskController extends GetxController {
  final TaskService taskService;
  late final AudioPlayer _audioPlayer;
  late final AudioRecorder _recorder;

  var audioPath = ''.obs;
  var isPlaying = false.obs;
  var isRecording = false.obs;
  var audioPlayed = false.obs;
  var currentTask = Rx<TaskInstanceEntity?>(null);
  var taskMode = Rx<TaskMode>(TaskMode.play);
  var currentTaskEntity = Rx<TaskEntity?>(null);

  var currentTaskIndex = 1.obs;
  var totalTasks = 1.obs;
  var moduleInstanceId = Rxn<int>();
  var isModuleCompleted = false.obs;

  DateTime? _audioStopTime;
  DateTime? _buttonClickTime;

  TaskController({required this.taskService});

  @override
  Future<void> onInit() async {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    final args = Get.arguments as Map<String, dynamic>;
    moduleInstanceId.value = args[RouteArguments.MODULE_INSTANCE_ID];

    // If there's a moduleInstanceId, calculate tasks based on it.
    if (moduleInstanceId.value != null) {
      // Calculate total tasks for the module instance.
      await _calculateTotalTasks(moduleInstanceId.value!);
    } else {
      // Fallback or error handling if moduleInstanceId is not provided.
      print("Module instance ID not found in arguments.");
    }

    // Update the current task based on the task instance ID passed in the arguments.
    if (args[RouteArguments.TASK_INSTANCE_ID] != null) {
      await updateCurrentTask(args[RouteArguments.TASK_INSTANCE_ID]);
    } else {
      // Fallback or error handling if task instance ID is not provided.
      print("Task instance ID not found in arguments.");
    }

    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      audioPlayed.value = true;
      _audioStopTime = DateTime.now();
    });

    taskMode.listen((mode) {
      print("Task mode changed to: $mode");
    });
  }

  // Function to calculate progress
  double get progress =>
      totalTasks.value > 0 ? currentTaskIndex.value / totalTasks.value : 0.0;

  // Function to proceed to the next task
  void nextTask() {
    if (currentTaskIndex.value < totalTasks.value - 1) {
      currentTaskIndex.value++;
      // Load the next task or handle it accordingly
    }
  }

  // Function to reset the task progress
  void resetProgress() {
    currentTaskIndex.value = 0;
  }

  Future<void> updateCurrentTask(int taskInstanceId) async {
    try {
      var taskInstance = await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        currentTask.value = taskInstance;
        var taskEntity = await taskService.getTask(taskInstance.taskID);
        currentTaskEntity.value = taskEntity;

        // Example condition to set taskMode
        if (taskEntity != null && taskEntity.taskMode == TaskMode.record) {
          taskMode.value = TaskMode.record;
        } else {
          taskMode.value = TaskMode.play;
        }

        var taskPrompt = await taskService
            .getTaskPromptByTaskInstanceID(taskInstance.taskID);
        audioPath.value =
            taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';
      }
    } catch (e) {
      print("Error updating current task: $e");
      audioPath.value = 'assets/audio/audio_placeholder.mp3';
    }
  }

  Future<void> togglePlay() async {
    if (!isPlaying.value) {
      await play();
    } else {
      await stop();
    }
  }

  Future<void> play() async {
    Source source = DeviceFileSource(audioPath.value);
    await _audioPlayer.play(source);
    isPlaying.value = true;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    audioPlayed.value = true;
    _audioStopTime = DateTime.now();
  }

  Future<void> startRecording() async {
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
    } else {
      // Handle permission not granted
    }
  }

  Future<void> stopRecording() async {
    final path = await _recorder.stop();
    isRecording.value = false;
    if (path != null) {
      audioPath.value = path;
    }
  }

  Future<void> saveAudio(ByteData data, String fileName) async {
    String path = await saveAudioFile(data, fileName);
    audioPath.value = path;
  }

  Future<String> _getRecordingPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = path.join(directory.path, 'recording_$timestamp.aac');
    return filePath;
  }

  Future<void> onCheckButtonPressed() async {
    // Complete the current task
    await concludeTaskInstance(currentTask.value?.taskInstanceID ?? 0);

    // Check if there are more tasks to fetch
    var nextTaskInstance = await taskService.getFirstPendingTaskInstance();
    if (nextTaskInstance != null) {
      // If there is a next task, increment the index and proceed
      currentTaskIndex.value++;
      await updateCurrentTask(nextTaskInstance.taskInstanceID!);
    } else {
      // If there are no more pending tasks, mark module as completed
      isModuleCompleted.value = true;
    }
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
    } else  if (currentTask.value != null && currentTaskIndex.value < totalTasks.value) {
      await concludeTaskInstance(currentTask.value!.taskInstanceID!);

      // Fetch the next pending task instance
      final nextTaskInstance = await taskService.getFirstPendingTaskInstance();
      if (nextTaskInstance != null) {
        // Update the current task
        currentTask.value = nextTaskInstance;
        // Fetch task entity for the next task
        var taskEntity = await taskService.getTask(nextTaskInstance.taskID);
        if (taskEntity != null) {
          currentTaskEntity.value = taskEntity;
          taskMode.value = taskEntity.taskMode;

          // Fetch and set the audio path for the next task
          var taskPrompt = await taskService
              .getTaskPromptByTaskInstanceID(nextTaskInstance.taskID);
          audioPath.value = taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';

          // Reset audio player and recording states
          audioPlayed.value = false;
          isPlaying.value = false;
          if (isRecording.value) {
            await stopRecording();
          }
        }
      } else {
        // No more tasks available, mark module as completed
        isModuleCompleted.value = true;
      }
    }
  }





  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.onClose();
  }

  Future<void> _calculateTotalTasks(int moduleInstanceId) async {
    final taskInstances = await taskService.getTasksByModuleInstanceId(moduleInstanceId);
    totalTasks.value = taskInstances.length;
  }
}
