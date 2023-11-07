import 'package:get/get.dart';
import 'modulo_controller.dart';

class ModuloBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModuloController(
      moduloRepository: Get.find(),
      tarefaRepository: Get.find(),
      // Add other dependencies if needed
    ));
  }
}
