import 'package:get/get.dart';
import '../../app/data/datasource/evaluator_local_datasource.dart';
import '../../app/domain/repositories/evaluator_repository.dart';
import '../evaluators/evaluators_controller.dart';
import 'evaluator_registration_controller.dart';

class EvaluatorRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure EvaluatorsController is available
    Get.find<EvaluatorsController>();

    // Pass EvaluatorsController to EvaluatorRegistrationController
    Get.lazyPut(() => EvaluatorRegistrationController(Get.find(), Get.find<EvaluatorsController>()));
  }
}
