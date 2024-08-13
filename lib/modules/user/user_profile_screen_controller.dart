import 'package:get/get.dart';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/module/module_entity.dart';
import '../../app/module/module_repository.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/module_instance/module_instance_repository.dart';
import '../../app/participant/participant_entity.dart';
import '../../app/participant/participant_repository.dart';
import '../../app/task/task_entity.dart';
import '../../app/task/task_repository.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../app/task_instance/task_instance_repository.dart';
import '../../global/typedefs.dart';
import '../../global/user_service.dart';

class UserProfileScreenController extends GetxController {
  final UserService userService = Get.find<UserService>();
  final ParticipantRepository participantRepository = Get.find<ParticipantRepository>();
  final TaskInstanceRepository taskInstanceRepository = Get.find<TaskInstanceRepository>();
  final TaskRepository taskRepository = Get.find<TaskRepository>();
  final ModuleInstanceRepository moduleInstanceRepository = Get.find<ModuleInstanceRepository>();
  final ModuleRepository moduleRepository = Get.find<ModuleRepository>();

  final Rx<EvaluatorEntity?> userAvaliador = Rx<EvaluatorEntity?>(null);
  final RxList<EvaluationEntity> evaluations = <EvaluationEntity>[].obs;
  RxMap<EvaluationEntity, Map<ModuleInstanceEntity, List<TaskInstanceEntity>>> evaluationMap = RxMap({});
  RxMap<int, ParticipantEntity> participants = RxMap({});
  RxMap<int, ModuleEntity> modules = RxMap({});
  RxMap<int, TaskEntity> tasks = RxMap({});

  @override
  void onInit() {
    super.onInit();
    userAvaliador.value = userService.user.value;
    fetchAllData();
  }

  void fetchAllData() async {
    evaluations.assignAll(userService.evaluations);
    for (var evaluation in evaluations) {
      ParticipantEntity? participant = await participantRepository.getParticipantByEvaluation(evaluation.participantID);
      participants[evaluation.participantID] = participant!;
      var moduleInstances = await moduleInstanceRepository.getModuleInstancesByEvaluationId(evaluation.evaluationID!);

      Map<ModuleInstanceEntity, List<TaskInstanceEntity>> taskMap = {};
      for (var moduleInstance in moduleInstances) {
        ModuleEntity? module = await moduleRepository.getModule(moduleInstance.moduleID);
        modules[moduleInstance.moduleID] = module!;

        var taskInstances = await taskInstanceRepository.getTaskInstancesByModuleInstanceId(moduleInstance.moduleInstanceID!);
        List<TaskInstanceEntity> taskList = [];
        for (var taskInstance in taskInstances) {
          TaskEntity? task = await taskRepository.getTask(taskInstance.taskID);
          tasks[taskInstance.taskID] = task!;
          taskList.add(taskInstance);
        }
        taskMap[moduleInstance] = taskList;
      }
      evaluationMap[evaluation] = taskMap;  // This ensures you are using the reactive map directly.
    }
  }
}