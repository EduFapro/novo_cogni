import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/module_instance_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/module_instance_repository.dart';
import 'package:novo_cogni/app/domain/repositories/module_repository.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/data/datasource/module_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import 'evaluation_controller.dart';
import 'evaluation_service.dart';

class EvaluationBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ModuleLocalDataSource());
    Get.lazyPut(() => TaskLocalDataSource());
    Get.lazyPut(() => ModuleInstanceLocalDataSource());


    // Register repositories with their respective data sources
    Get.put(
        ModuleRepository(
            moduleLocalDataSource: Get.find(),
            taskLocalDataSource: Get.find()),
        permanent: true);
    Get.put(TaskRepository(localDataSource: Get.find()), permanent: true);
    Get.put(ModuleInstanceRepository(moduleInstanceLocalDataSource: Get.find()));



    var moduleService = EvaluationService(
        moduleRepository: Get.find<ModuleRepository>(),
        taskRepository: Get.find<TaskRepository>(),
        moduleInstanceRepository: Get.find<ModuleInstanceRepository>(),);
    Get.put(moduleService, permanent: true);

    Get.put(
      EvaluationController(moduleService: moduleService),
      permanent: false,
    );
  }
}
