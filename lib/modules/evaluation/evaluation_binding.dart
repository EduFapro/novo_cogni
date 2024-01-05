import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/module_instance_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/module_instance_repository.dart';
import 'package:novo_cogni/app/domain/repositories/module_repository.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/data/datasource/module_local_datasource.dart';
import '../../app/data/datasource/task_instance_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import '../../app/domain/repositories/task_instance_repository.dart';
import 'evaluation_controller.dart';
import 'evaluation_service.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModuleLocalDataSource());
    Get.lazyPut(() => ModuleInstanceLocalDataSource());
    Get.lazyPut(() => TaskLocalDataSource());
    Get.lazyPut(() => TaskInstanceLocalDataSource());

    Get.put(
        ModuleRepository(
            moduleLocalDataSource: Get.find(), taskLocalDataSource: Get.find()),
        permanent: true);
    Get.put(
        ModuleInstanceRepository(moduleInstanceLocalDataSource: Get.find()));
    Get.put(TaskInstanceRepository(localDataSource: Get.find()));
    Get.put(TaskRepository(localDataSource: Get.find()), permanent: true);

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
