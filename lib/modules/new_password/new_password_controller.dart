import 'dart:ffi';

import 'package:get/get.dart';
import 'package:novo_cogni/app/evaluation/evaluation_entity.dart';
import 'package:novo_cogni/constants/route_arguments.dart';

import '../../app/evaluator/evaluator_repository.dart';

class NewPasswordController extends GetxController {
  late bool isFirstLogin;
  late EvaluationEntity evaluator;

  final EvaluatorRepository evaluatorRepository;

  NewPasswordController({required this.evaluatorRepository});

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    isFirstLogin = arguments[RouteArguments.FIRST_LOGIN];
    evaluator = arguments[RouteArguments.EVALUATOR];
  }

  Future<void> changePassword(String newPassword) async {
    var fetchedEvaluator = await evaluatorRepository.getEvaluator(evaluator.evaluatorID);
    if (fetchedEvaluator != null) {
      fetchedEvaluator.password = newPassword;
      fetchedEvaluator.firstLogin = false;

      await evaluatorRepository.updateEvaluator(fetchedEvaluator);
    }
  }
}
