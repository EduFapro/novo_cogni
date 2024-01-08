import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/module_instance_repository.dart';
import 'package:novo_cogni/app/domain/repositories/module_repository.dart';
import 'package:novo_cogni/app/domain/repositories/task_instance_repository.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_service.dart';

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

    Get.lazyPut(
          () => EvaluationController(evaluationService: moduleService),
      fenix: true,
    );
  }
}
