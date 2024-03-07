import 'package:get/get.dart';
import 'package:novo_cogni/app/evaluator/evaluator_entity.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/module_instance/module_instance_entity.dart';

class UserProfileScreenController extends GetxController {
  final UserService userService = Get.find<UserService>();

  final Rx<EvaluatorEntity?> userAvaliador = Rx<EvaluatorEntity?>(null);
  RxList<EvaluationEntity> evaluations = <EvaluationEntity>[].obs;
  RxMap<int, List<ModuleInstanceEntity>> modules = <int, List<ModuleInstanceEntity>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    userAvaliador.value = userService.user.value;
    evaluations.value = userService.evaluations;
    modules.value = userService.modules;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
