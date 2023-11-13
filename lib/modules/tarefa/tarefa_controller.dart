import 'package:get/get.dart';
import '../audio_player/audio_recorder_controller.dart';

class TarefaController extends GetxController {
  final audioRecorderController = AudioRecorderController();

  @override
  void onInit() {
    super.onInit();
    // Initialize anything when the controller is created
  }

  @override
  void onClose() {
    audioRecorderController.dispose();
    super.onClose();
  }

// ... other methods
}
