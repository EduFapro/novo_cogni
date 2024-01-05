import 'package:get/get.dart';
import 'package:novo_cogni/modules/participant_registration/participant_registration_controller.dart';
import 'package:novo_cogni/modules/participant_registration/participant_registration_service.dart';

import '../../app/data/datasource/evaluation_local_datasource.dart';
import '../../app/data/datasource/module_instance_local_datasource.dart';
import '../../app/data/datasource/module_local_datasource.dart';
import '../../app/data/datasource/participant_local_datasource.dart';
import '../../app/data/datasource/task_instance_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import '../../app/domain/repositories/evaluation_repository.dart';
import '../../app/domain/repositories/module_instance_repository.dart';
import '../../app/domain/repositories/module_repository.dart';
import '../../app/domain/repositories/participant_repository.dart';
import '../../app/domain/repositories/task_instance_repository.dart';
import '../../app/domain/repositories/task_repository.dart';

class ParticipantRegistrationBinding extends Bindings {
  @override
  void dependencies() {


    // Register service
    Get.lazyPut<ParticipantRegistrationService>(
            () => ParticipantRegistrationService(
          moduleInstanceRepository: Get.find<ModuleInstanceRepository>(),
          participantRepository: Get.find<ParticipantRepository>(),
          evaluationRepository: Get.find<EvaluationRepository>(),
          moduleRepository: Get.find<ModuleRepository>(),
          taskRepository: Get.find<TaskRepository>(),
          taskInstanceRepository: Get.find<TaskInstanceRepository>(),
        ));

    // Register controller with the service
    Get.lazyPut<ParticipantRegistrationController>(() =>
        ParticipantRegistrationController(
            Get.find<ParticipantRegistrationService>()));
  }
}
