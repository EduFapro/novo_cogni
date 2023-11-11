import 'package:get/get.dart';

import '../audio_player/audio_recorder_controller.dart';

class TarefaController extends GetxController {
  final audioRecorderController = AudioRecorderController().obs;

  // Add any other variables and methods needed for the TarefaScreen

  @override
  void onInit() {
    super.onInit();
    // Initialize anything when the controller is created
  }

  @override
  void onClose() {
    // Dispose resources when the controller is removed from memory
    audioRecorderController.value.dispose();
    super.onClose();
  }

// Add methods to control audio recording, playback, etc.
}
