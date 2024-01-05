import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/module_instance_repository.dart';
import 'package:novo_cogni/app/domain/repositories/module_repository.dart';

import '../../app/domain/repositories/task_instance_repository.dart';
import 'evaluation_controller.dart';
import 'evaluation_service.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {

    var moduleService = EvaluationService(
      moduleRepository: Get.find<ModuleRepository>(),
      taskInstanceRepository: Get.find<TaskInstanceRepository>(),
      moduleInstanceRepository: Get.find<ModuleInstanceRepository>(),
      taskRepository: Get.find(),
    );
    Get.put(moduleService, permanent: true);

    Get.put(
      EvaluationController(evaluationService: moduleService),
      permanent: false,
    );
  }
}
