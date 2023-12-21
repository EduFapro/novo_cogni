import 'package:get/get.dart';

import '../../app/domain/repositories/evaluator_repository.dart';

class NewPasswordController extends GetxController {
  late bool isFirstLogin;
  late int evaluatorId;

  final EvaluatorRepository evaluatorRepository;

  NewPasswordController({required this.evaluatorRepository});

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    isFirstLogin = arguments['firstLogin'];
    evaluatorId = arguments['evaluatorId'];
  }

  Future<void> changePassword(String newPassword) async {
    var fetchedEvaluator = await evaluatorRepository.getEvaluator(evaluatorId);
    if (fetchedEvaluator != null) {
      fetchedEvaluator.password = newPassword;
      fetchedEvaluator.firstLogin = false;

      await evaluatorRepository.updateEvaluator(fetchedEvaluator);
    }
  }
}
