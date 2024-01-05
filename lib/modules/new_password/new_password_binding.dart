import 'package:get/get.dart';

import '../../app/data/datasource/evaluator_local_datasource.dart';
import '../../app/domain/repositories/evaluator_repository.dart';
import 'new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => NewPasswordController(
          evaluatorRepository: Get.find<EvaluatorRepository>(),
        ));


  }
}
