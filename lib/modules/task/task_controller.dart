import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:novo_cogni/constants/route_arguments.dart';
import 'package:novo_cogni/modules/task/task_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

import '../../app/domain/entities/task_instance_entity.dart';
import '../../constants/enums/task_enums.dart';
import '../../file_management/audio_management.dart';
import '../evaluation/evaluation_controller.dart';

class TaskController extends GetxController {
  final TaskService taskService;

  // Dependency controllers
  late final AudioPlayer _audioPlayer;
  late final AudioRecorder _recorder;

  // Observable states
  var audioPath = ''.obs;
  var isPlaying = false.obs;
  var isRecording = false.obs;
  var audioPlayed = false.obs;

  DateTime? _audioStopTime;
  DateTime? _buttonClickTime;

  late final taskId;
  late final taskInstanceId;
  late final taskName;

  TaskController({required this.taskService});

  @override
  Future<void> onInit() async {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;
    
    taskId = args[RouteArguments.TASK_ID];
    taskName = args[RouteArguments.TASK_NAME];
    taskInstanceId = args[RouteArguments.TASK_INSTANCE_ID];

    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    // Set a default path for audio

    try {
      audioPath.value = await getPromptAudioFilePath();
    } catch (e) {
      print("Error fetching audio file: $e");
      audioPath.value = 'assets/audio/audio_placeholder.mp3';
    }

    // Listen for audio player events
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false; // Set isPlaying to false when playback completes
      audioPlayed.value =
          true; // Set audioPlayed to true when playback completes
      _audioStopTime = DateTime.now(); // Save the stop time
    });
  }

  // Player functions
  Future<void> togglePlay(String path) async {
    if (isPlaying.value) {
      await stop();
    } else {
      await play(path);
    }
  }

  Future<void> play(String path) async {
    Source source = DeviceFileSource(path);
    await _audioPlayer.play(source);
    isPlaying.value = true;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    audioPlayed.value = true;
    _audioStopTime = DateTime.now();
  }

  // Recorder functions
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
      // Handle the scenario when the permission is not granted.
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
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath =
        path.join(directory.path, 'recording_$timestamp.aac');
    return filePath;
  }

  Future<void> onCheckButtonPressed() async {
    await concludeTaskInstance(taskInstanceId);

    // Fetch the task instance
    TaskInstanceEntity? taskInstance = await taskService.getTaskInstance(taskInstanceId);
    if (taskInstance != null && taskInstance.status == TaskStatus.done) {
      // Find the EvaluationController and launch the next task
      final evaluationController = Get.find<EvaluationController>();
      await evaluationController.launchNextTask();
    }
  }


  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.onClose();
  }

  Future<String> getPromptAudioFilePath() async {
    final taskPrompt = await taskService.getTaskPromptByTaskInstanceID(taskId);
    if (taskPrompt != null) {
      return taskPrompt.filePath;
    } else {
      throw Exception("Task prompt not found for task instance ID: $taskId");
    }
  }

  Future<void> concludeTaskInstance(int taskInstanceId) async {
    try {
      // Fetch the task instance
      TaskInstanceEntity? taskInstance = await taskService.getTaskInstance(taskInstanceId);

      if (taskInstance != null) {
        // Update status to reflect task completion
        taskInstance.status = TaskStatus.done;

        // If there is a stop time for the audio, calculate the duration
        if (_audioStopTime != null) {
          final duration = DateTime.now().difference(_audioStopTime!);
          taskInstance.completeTask(duration);
        }

        // Update the task instance in the database
        bool updated = await taskService.updateTaskInstance(taskInstance);
        if (!updated) {
          print('Error updating task instance');
          // Handle update failure
        }
      } else {
        print('Task instance not found');
        // Handle the case when task instance is not found
      }
    } catch (e) {
      print('Error in concludeTaskInstance: $e');
      // Handle exceptions
    }
  }


}
