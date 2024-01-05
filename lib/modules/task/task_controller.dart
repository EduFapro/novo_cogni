import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:novo_cogni/modules/task/task_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

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

  TaskController({required this.taskService});

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _recorder = AudioRecorder();

    // Set a default path for audio
    audioPath.value = 'assets/audio/audio_placeholder.mp3';
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
  @override
  void onClose() {
    _audioPlayer.dispose();
    _recorder.dispose();
    super.onClose();
  }
}
