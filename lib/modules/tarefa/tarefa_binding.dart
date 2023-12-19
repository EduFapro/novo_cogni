import 'package:get/get.dart';
import '../../audio_player/audio_player_controller.dart';
import 'tarefa_controller.dart';

class TarefaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TarefaController>(() => TarefaController());
    Get.lazyPut<AudioPlayerController>(() => AudioPlayerController());
  }
}
