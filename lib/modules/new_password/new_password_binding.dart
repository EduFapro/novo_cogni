import 'package:get/get.dart';

import '../../app/evaluator/evaluator_repository.dart';
import 'new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => NewPasswordController(
          evaluatorRepository: Get.find<EvaluatorRepository>(),
        ));


  }
}
