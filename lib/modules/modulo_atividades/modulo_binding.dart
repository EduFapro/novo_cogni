import 'package:get/get.dart';
import 'modulo_controller.dart';

class ModuloBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => ModuloController(
      moduloRepository: Get.find(),
      tarefaRepository: Get.find(),
    ));
  }
}
