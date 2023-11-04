import 'package:get/get.dart';
import 'modulo_controller.dart';

class ModuloBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuloController>(() => ModuloController());
  }
}
