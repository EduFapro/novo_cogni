import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/evaluation_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/evaluator_repository.dart';
import 'evaluators_controller.dart';

class EvaluatorsBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(EvaluatorsController(), permanent: true);


  }
}
