import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/evaluator_repository.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
            () => LoginController(Get.find<EvaluatorRepository>())
    );
  }
}
