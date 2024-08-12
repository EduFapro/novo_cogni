import 'package:get/get.dart';
import '../evaluators/evaluators_controller.dart';
import 'admin_registration_controller.dart';

class AdminRegistrationBinding extends Bindings {
  @override
  void dependencies() {

    // Pass EvaluatorsController to EvaluatorRegistrationController
    Get.lazyPut(() => AdminRegistrationController(Get.find(), Get.find<EvaluatorsController>()));
  }
}
