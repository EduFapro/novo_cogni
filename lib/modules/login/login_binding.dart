import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/avaliador_repository.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
            () => LoginController(Get.find<AvaliadorRepository>())
    );
  }
}
