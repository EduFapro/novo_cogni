import 'package:get/get.dart';
import 'package:novo_cogni/modules/task/task_controller.dart';
import '../../audio_player/audio_player_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
    Get.lazyPut<AudioPlayerController>(() => AudioPlayerController());
  }
}
