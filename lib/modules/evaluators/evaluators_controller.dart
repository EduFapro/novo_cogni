import 'package:get/get.dart';

import '../../app/evaluator/evaluator_entity.dart';
import '../../app/evaluator/evaluator_local_datasource.dart';
import '../../app/evaluator/evaluator_repository.dart';

class EvaluatorsController extends GetxController {
  var evaluatorsList = <EvaluatorEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvaluators();
  }

  void fetchEvaluators() async {
    var evaluators = await EvaluatorRepository(localDataSource: EvaluatorLocalDataSource()).getAllEvaluators();
    evaluatorsList.assignAll(evaluators);
    }

  void addEvaluator(EvaluatorEntity newEvaluator) {
    evaluatorsList.add(newEvaluator);
    update();
  }
}
