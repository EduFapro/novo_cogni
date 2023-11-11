import 'package:get/get.dart';
import 'tarefa_controller.dart';

class TarefaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TarefaController>(() => TarefaController());
    // You can put other dependencies here if needed
  }
}
