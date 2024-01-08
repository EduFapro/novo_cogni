import 'package:get/get.dart';
import 'package:novo_cogni/modules/task/task_controller.dart';
import 'package:novo_cogni/modules/task/task_service.dart';

import '../../app/domain/repositories/task_instance_repository.dart';
import '../../app/domain/repositories/task_prompt_repository.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskService>(
          () => TaskService(
        taskPromptRepository: Get.find<TaskPromptRepository>(),
        taskInstanceRepository: Get.find<TaskInstanceRepository>(),
      ),
    );

    // Use fenix to recreate TaskController when needed
    Get.lazyPut<TaskController>(
          () => TaskController(taskService: Get.find()),
      fenix: true,
    );
  }
}
