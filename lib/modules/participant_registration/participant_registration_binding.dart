import 'package:get/get.dart';
import 'package:novo_cogni/modules/participant_registration/participant_registration_controller.dart';
import 'package:novo_cogni/modules/participant_registration/participant_registration_service.dart';
import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/participant_local_datasource.dart';
import '../../app/data/datasource/evaluation_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import '../../app/domain/repositories/participant_repository.dart';
import '../../app/domain/repositories/evaluation_repository.dart';
import '../../app/domain/repositories/module_repository.dart';
import '../../app/domain/repositories/task_repository.dart';

class ParticipantRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ParticipantLocalDataSource());
    Get.lazyPut(() => EvaluationLocalDataSource());
    Get.lazyPut(() => ModuleLocalDataSource());
    Get.lazyPut(() => TaskLocalDataSource());

    // Register repositories with their respective data sources
    Get.lazyPut<ParticipantRepository>(() => ParticipantRepository(localDataSource: Get.find()));
    Get.lazyPut<EvaluationRepository>(() => EvaluationRepository(localDataSource: Get.find()));
    Get.lazyPut<ModuleRepository>(() => ModuleRepository(
      moduleLocalDataSource: Get.find(),
      taskLocalDataSource: Get.find(),
    ));
    Get.lazyPut<TaskRepository>(() => TaskRepository(localDataSource: Get.find()));

    // Register service
    Get.lazyPut<ParticipantRegistrationService>(() => ParticipantRegistrationService(
      participantRepository: Get.find<ParticipantRepository>(),
      evaluationRepository: Get.find<EvaluationRepository>(),
      moduleRepository: Get.find<ModuleRepository>(),
      taskRepository: Get.find<TaskRepository>(),
    ));

    // Register controller with the service
    Get.lazyPut<ParticipantRegistrationController>(() => ParticipantRegistrationController(Get.find<ParticipantRegistrationService>()));
  }
}
