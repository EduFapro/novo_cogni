import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/module_repository.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import 'modules_list_controller.dart';
import 'modules_list_service.dart';

class ModulesListBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ModuleLocalDataSource());
    Get.lazyPut(() => TaskLocalDataSource());


    // Register repositories with their respective data sources
    Get.put(
        ModuleRepository(
            moduleLocalDataSource: Get.find(),
            taskLocalDataSource: Get.find()),
        permanent: true);
    Get.put(TaskRepository(localDataSource: Get.find()), permanent: true);



    var moduleService = ModulesListService(
        moduleRepository: Get.find<ModuleRepository>(),
        taskRepository: Get.find<TaskRepository>());
    Get.put(moduleService, permanent: true);

    Get.put(
      ModulesListController(moduleService: moduleService),
      permanent: false,
    );
    // Get.put(
    //   ModulesListService(
    //       moduleRepository: Get.find<ModuleRepository>(),
    //       evaluationModuleRepository: evaluationModuleRepo),
    //   permanent: true,
    // );
  }
}
