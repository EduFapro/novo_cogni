import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/evaluation_entity.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/app/domain/entities/participant_entity.dart';
import 'package:novo_cogni/constants/route_arguments.dart';
import '../../app/domain/entities/module_instance_entity.dart';
import '../../app/domain/entities/task_entity.dart';
import '../../app/domain/entities/task_instance_entity.dart';
import '../../routes.dart';
import 'evaluation_service.dart';

class EvaluationController extends GetxController {
  final EvaluationService evaluationService = Get.find<EvaluationService>();

  var participant = Rxn<ParticipantEntity>();
  var evaluation = Rxn<EvaluationEntity>();
  var modulesInstanceList = Rx<List<ModuleInstanceEntity>?>(null);
  var tasksListDetails = Rx<List<Map<int, List<TaskInstanceEntity>>>>([]);

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    _initialize();
  }

  Future<void> _initialize() async {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      participant.value = arguments[RouteArguments.PARTICIPANT];
      evaluation.value = arguments[RouteArguments.EVALUATION];

      if (evaluation.value != null) {
        List<ModuleInstanceEntity>? modules = await evaluationService.getModuleInstancesByEvaluationId(evaluation.value!.evaluationID!);
        if (modules.isNotEmpty) {
          modulesInstanceList.value = modules;
          await fetchTaskInstancesForModuleInstances(modules);
        }
      }
    }
    isLoading(false);
  }

  Future<List<ModuleEntity>?> getModulesByEvaluationId(int evaluationId) async => await evaluationService.getModulesByEvaluationId(evaluationId);

  Future<void> fetchTaskInstancesForModuleInstances(List<ModuleInstanceEntity> moduleInstances) async {
    for (var moduleInstance in moduleInstances) {
      var tasks = await evaluationService.getTasksByModuleId(moduleInstance.moduleInstanceID!);
      if (tasks != null && tasks.isNotEmpty) {
        tasksListDetails.update((val) {
          val?.add({moduleInstance.moduleID: tasks});
        });
      }
    }
  }

  Future<void> launchNextTask() async {
    final nextTaskInstance = await evaluationService.getFirstPendingTaskInstance();
    if (nextTaskInstance != null) {
      final taskEntity = await nextTaskInstance.task;
      if (taskEntity != null) {
        navigateToTask(taskEntity, nextTaskInstance.taskInstanceID!);
      }
    }
  }

  void navigateToTask(TaskEntity taskEntity, int taskInstanceId) {
    Get.toNamed(
      AppRoutes.task,
      arguments: {
        RouteArguments.TASK_NAME: taskEntity.title,
        RouteArguments.TASK_ID: taskEntity.taskID,
        RouteArguments.TASK_INSTANCE_ID: taskInstanceId,
      },
    );
  }

  // Getter for participant's age
  int get age {
    if (participant.value?.birthDate == null) return 0;
    final birthDate = participant.value!.birthDate;
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (birthDate.month > today.month || (birthDate.month == today.month && birthDate.day > today.day)) {
      age--;
    }
    return age;
  }

  // Method to fetch tasks for a given module instance ID
  Future<List<TaskInstanceEntity>> getTasks(int moduleInstanceId) async {
    List<TaskInstanceEntity>? tasks = await evaluationService.getTasksByModuleId(moduleInstanceId);
    return tasks ?? [];
  }

}
