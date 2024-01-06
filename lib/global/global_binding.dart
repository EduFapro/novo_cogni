import 'package:get/get.dart';
import 'package:novo_cogni/global/user_controller.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../app/data/datasource/evaluation_local_datasource.dart';
import '../app/data/datasource/evaluator_local_datasource.dart';
import '../app/data/datasource/module_instance_local_datasource.dart';
import '../app/data/datasource/module_local_datasource.dart';
import '../app/data/datasource/participant_local_datasource.dart';
import '../app/data/datasource/task_instance_local_datasource.dart';
import '../app/data/datasource/task_local_datasource.dart';
import '../app/data/datasource/task_prompt_local_datasource.dart';
import '../app/domain/repositories/evaluation_repository.dart';
import '../app/domain/repositories/evaluator_repository.dart';
import '../app/domain/repositories/module_instance_repository.dart';
import '../app/domain/repositories/module_repository.dart';
import '../app/domain/repositories/participant_repository.dart';
import '../app/domain/repositories/task_instance_repository.dart';
import '../app/domain/repositories/task_prompt_repository.dart';
import '../app/domain/repositories/task_repository.dart';
import 'language_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Data Sources and Repositories

    // Evaluator
    Get.lazyPut<EvaluatorLocalDataSource>(() => EvaluatorLocalDataSource(), fenix: true);
    Get.lazyPut<EvaluatorRepository>(() => EvaluatorRepository(localDataSource: Get.find()), fenix: true);

    // Evaluation
    Get.lazyPut<EvaluationLocalDataSource>(() => EvaluationLocalDataSource(), fenix: true);
    Get.lazyPut<EvaluationRepository>(() => EvaluationRepository(localDataSource: Get.find()), fenix: true);

    // Participant
    Get.lazyPut<ParticipantLocalDataSource>(() => ParticipantLocalDataSource(), fenix: true);
    Get.lazyPut<ParticipantRepository>(() => ParticipantRepository(localDataSource: Get.find()), fenix: true);

    // Module and Task
    Get.lazyPut<ModuleLocalDataSource>(() => ModuleLocalDataSource(), fenix: true);
    Get.lazyPut<TaskLocalDataSource>(() => TaskLocalDataSource(), fenix: true);
    Get.lazyPut<ModuleRepository>(() => ModuleRepository(moduleLocalDataSource: Get.find(), taskLocalDataSource: Get.find()), fenix: true);
    Get.lazyPut<TaskRepository>(() => TaskRepository(localDataSource: Get.find()), fenix: true);

    // Module Instance
    Get.lazyPut<ModuleInstanceLocalDataSource>(() => ModuleInstanceLocalDataSource(), fenix: true);
    Get.lazyPut<ModuleInstanceRepository>(() => ModuleInstanceRepository(moduleInstanceLocalDataSource: Get.find()), fenix: true);

    // Task Instance
    Get.lazyPut<TaskInstanceLocalDataSource>(() => TaskInstanceLocalDataSource(), fenix: true);
    Get.lazyPut<TaskInstanceRepository>(() => TaskInstanceRepository(localDataSource: Get.find()), fenix: true);

    // Task Prompt
    Get.lazyPut<TaskPromptLocalDataSource>(() => TaskPromptLocalDataSource(), fenix: true);
    Get.lazyPut<TaskPromptRepository>(() => TaskPromptRepository(localDataSource: Get.find()), fenix: true);

    // Core Services
    // User-related Services
    Get.put<UserService>(UserService(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put(LanguageController());
  }
}

