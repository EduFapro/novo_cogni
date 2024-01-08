import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;
import '../../app/domain/entities/task_instance_entity.dart';
import '../../app/domain/entities/task_entity.dart';
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

  DateTime? _audioStopTime;
  DateTime? _buttonClickTime;

  TaskController({required this.taskService});

  @override
  Future<void> onInit() async {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    final args = Get.arguments as Map<String, dynamic>;
    await updateCurrentTask(args['taskInstanceId']);

    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      audioPlayed.value = true;
      _audioStopTime = DateTime.now();
    });
  }

  Future<void> updateCurrentTask(int taskInstanceId) async {
    try {
      var taskInstance = await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        currentTask.value = taskInstance;
        var taskPrompt = await taskService.getTaskPromptByTaskInstanceID(taskInstance.taskID);
        audioPath.value = taskPrompt?.filePath ?? 'assets/audio/audio_placeholder.mp3';
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
      TaskInstanceEntity? taskInstance = await taskService.getTaskInstance(taskInstanceId);
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
  Future<void> launchNextTask() async {
    print("launch nekisti task");
    final nextTaskInstance = await taskService.getFirstPendingTaskInstance();
    if (nextTaskInstance != null) {
      final taskEntity = await nextTaskInstance.task;
      if (taskEntity != null) {
        // Update the current task without navigating to a new screen
        currentTask.value = nextTaskInstance;
        audioPath.value = (await taskService.getTaskPromptByTaskInstanceID(nextTaskInstance.taskID))?.filePath ?? 'assets/audio/audio_placeholder.mp3';
        audioPlayed.value = false;
        isPlaying.value = false;

        // Reset the audio player
        var currentPosition = await _audioPlayer.getCurrentPosition();
        if (currentPosition!.inMilliseconds > 0) {
          await _audioPlayer.stop();
        }

      }
    }
  }
  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.onClose();
  }
}
