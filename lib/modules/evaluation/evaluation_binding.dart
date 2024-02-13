import 'package:get/get.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_service.dart';

import '../../app/module/module_repository.dart';
import '../../app/module_instance/module_instance_repository.dart';
import '../../app/task/task_repository.dart';
import '../../app/task_instance/task_instance_repository.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate EvaluationService with required repositories
    EvaluationService moduleService = EvaluationService(
      moduleRepository: Get.find<ModuleRepository>(),
      taskRepository: Get.find<TaskRepository>(),
      taskInstanceRepository: Get.find<TaskInstanceRepository>(),
      moduleInstanceRepository: Get.find<ModuleInstanceRepository>(),
    );

    // Put EvaluationService into GetX storage to be used globally
    Get.put<EvaluationService>(moduleService, permanent: true);

    // Lazy put EvaluationController into GetX storage, ensuring it can be retrieved later
    Get.lazyPut<EvaluationController>(
          () => EvaluationController(),
      fenix: true, // fenix: true will recreate the controller if it was ever disposed.
    );
  }
}
