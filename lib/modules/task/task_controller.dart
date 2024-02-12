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
import '../evaluation/evaluation_controller.dart';
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

  // Observables to keep track of the current task index and the total number of tasks.
  var currentTaskIndex = 0.obs;
  var totalTasks = 1.obs; // Make sure to set this when the tasks are loaded.

  DateTime? _audioStopTime;
  DateTime? _buttonClickTime;

  TaskController({required this.taskService});

  @override
  Future<void> onInit() async {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    final args = Get.arguments as Map<String, dynamic>;
    await updateCurrentTask(args[RouteArguments.TASK_INSTANCE_ID]);

    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      audioPlayed.value = true;
      _audioStopTime = DateTime.now();
    });
    taskMode.listen((mode) {
      print("Task mode changed to: $mode");
    });

    @override
    Future<void> onInit() async {
      super.onInit();
      // ... existing initialization code ...

      // Load all tasks from the service and set totalTasks.
      try {
        final tasks = await taskService.getAllTasks();
        tasks.sort((a, b) => a.position.compareTo(b.position)); // Sort by position.
        totalTasks.value = tasks.length;

        // Find the current task index based on the task instance.
        if (currentTask.value != null) {
          final currentTaskEntity = await taskService.getTask(currentTask.value!.taskID);
          if (currentTaskEntity != null) {
            currentTaskIndex.value = tasks.indexWhere((task) => task.taskID == currentTaskEntity.taskID) + 1;
          }
        }
      } catch (e) {
        print("Error loading tasks: $e");
      }
    }

  }

  // Function to calculate progress
  double get progress => totalTasks.value > 0 ? currentTaskIndex.value / totalTasks.value : 0.0;


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
    await concludeTaskInstance(currentTask.value?.taskInstanceID ?? 0);
    final evaluationController = Get.find<EvaluationController>();
    await launchNextTask();
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
    // ...
  }

  Future<void> launchNextTask() async {
    print("Launching next task");

    // First, ensure the current task is concluded
    await concludeTaskInstance(currentTask.value?.taskInstanceID ?? 0);

    // Fetch the next pending task instance
    final nextTaskInstance = await taskService.getFirstPendingTaskInstance();
    print("meudeususus 1 task controller");
    if (nextTaskInstance != null) {
      print("meudeususus 2 task controller");
      // Update the current task
      currentTask.value = nextTaskInstance;
      print("meudeususus 3 task controller");
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
      print("No more tasks available");
      // Handle the scenario when no more tasks are available
    }
  }


  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.onClose();
  }
}
