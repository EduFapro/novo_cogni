import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:novo_cogni/modules/task/task_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

import '../../app/domain/entities/task_instance_entity.dart';
import '../../file_management/audio_management.dart';

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

  TaskController({required this.taskService});

  @override
  Future<void> onInit() async {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final taskid = args['taskId'];
    final taskName = args['taskName'];
    print("taskId $taskid");
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    // Set a default path for audio

    try {
      audioPath.value = await getPromptAudioFilePath(taskid);
    } catch (e) {
      print("Error fetching audio file: $e");
      audioPath.value = 'assets/audio/audio_placeholder.mp3';
    }

    // Listen for audio player events
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false; // Set isPlaying to false when playback completes
      audioPlayed.value = true; // Set audioPlayed to true when playback completes
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
    final String filePath = path.join(directory.path, 'recording_$timestamp.aac');
    return filePath;
  }


  Future<void> onCheckButtonPressed(int taskInstanceId) async {
    _buttonClickTime = DateTime.now();

    if (_audioStopTime != null) {
      final duration = _buttonClickTime!.difference(_audioStopTime!);

      // Fetch the task instance
      TaskInstanceEntity? taskInstance = await taskService.getTaskInstance(taskInstanceId);
      if (taskInstance != null) {
        // Update the task instance
        taskInstance.completeTask(duration);

        // Update the task instance in the database
        bool updated = await taskService.updateTaskInstance(taskInstance);
        if (updated) {
          // Handle successful update
        } else {
          // Handle update failure
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

  Future<String> getPromptAudioFilePath(int taskId) async {
    print("taskInstanceId $taskId");
    final taskPrompt = await taskService.getTaskPromptByTaskInstanceID(taskId);
    if (taskPrompt != null) {
      return taskPrompt.filePath;
    } else {
      throw Exception("Task prompt not found for task instance ID: $taskId");
    }
  }
}
