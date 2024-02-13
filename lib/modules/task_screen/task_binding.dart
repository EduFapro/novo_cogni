import 'package:get/get.dart';
import 'package:novo_cogni/app/task/task_repository.dart';
import 'package:novo_cogni/modules/task_screen/task_screen_controller.dart';
import 'package:novo_cogni/modules/task_screen/task_screen_service.dart';

import '../../app/task_instance/task_instance_repository.dart';
import '../../app/task_prompt/task_prompt_repository.dart';

class TaskScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskScreenService>(
      () => TaskScreenService(
          taskPromptRepository: Get.find<TaskPromptRepository>(),
          taskInstanceRepository: Get.find<TaskInstanceRepository>(),
          taskRepository: Get.find<TaskRepository>()),
    );

    // Use fenix to recreate TaskController when needed
    Get.lazyPut<TaskScreenController>(
      () => TaskScreenController(taskService: Get.find()),
      fenix: true,
    );
  }
}
