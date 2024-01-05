import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/task_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';
import 'package:novo_cogni/modules/task/task_controller.dart';
import 'package:novo_cogni/modules/task/task_service.dart';

import '../../app/data/datasource/task_prompt_local_datasource.dart';
import '../../app/domain/repositories/task_prompt_repository.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<TaskService>(() => TaskService(taskPromptRepository: Get.find()));
    Get.lazyPut<TaskController>(() => TaskController(taskService: Get.find()));
  }
}
