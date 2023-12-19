import 'dart:typed_data';

import 'package:get/get.dart';
import '../../audio_player/audio_recorder_controller.dart';
import '../../utils/file_management/audio_management.dart';


class TarefaController extends GetxController {
  final audioRecorderController = AudioRecorderController();
  RxString audioPath = ''.obs; // Observable for the audio path

  @override
  void onInit() {
    super.onInit();
    audioPath.value = 'assets/audio/audio_placeholder.mp3';
  }

  Future<void> saveAudio(ByteData data, String fileName) async {
    String path = await saveAudioFile(data, fileName);
    audioPath.value = path; // Update the audio path
  }

  @override
  void onClose() {
    audioRecorderController.dispose();
    super.onClose();
  }
}
