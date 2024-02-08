import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/evaluation_entity.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/app/domain/entities/participant_entity.dart';
import 'package:novo_cogni/constants/route_arguments.dart';

import '../../app/domain/entities/module_instance_entity.dart';
import '../../app/domain/entities/task_instance_entity.dart';
import '../../app/domain/repositories/task_instance_repository.dart';
import '../../routes.dart';
import 'evaluation_service.dart';

class EvaluationController extends GetxController {
  final EvaluationService evaluationService;

  var participant = Rx<ParticipantEntity?>(null);
  var evaluation = Rx<EvaluationEntity?>(null);
  var modulesInstanceList = Rx<List<ModuleInstanceEntity?>?>(null);
  var tasksListDetails = Rx<List<Map<int, List<TaskInstanceEntity>>>>([]);

  var isLoading = false.obs;

  EvaluationController({required this.evaluationService});

  int get age {
    if (participant.value?.birthDate == null) {
      print("Birth date is null");
      return -1;
    }

    DateTime birthDate = participant
        .value!.birthDate; // Assuming this is already a DateTime object.
    return calculateAge(birthDate);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    // Retrieve and set the arguments
    final arguments = Get.arguments as Map<String, dynamic>;

    if (arguments.containsKey(RouteArguments.PARTICIPANT)) {
      participant.value = arguments[RouteArguments.PARTICIPANT];
    }
    if (arguments.containsKey(RouteArguments.EVALUATION)) {
      evaluation.value = arguments[RouteArguments.EVALUATION];
    }

    if (evaluation.value != null) {
      List<ModuleInstanceEntity>? modules =
          await getModuleInstancesByEvaluationId(
              evaluation.value!.evaluationID!);
      if (modules != null && modules.isNotEmpty) {
        modulesInstanceList.value = modules;
        await fetchTaskInstancesForModuleInstances(modules);
      }
    }
    isLoading.value = false;
  }

  Future<List<ModuleEntity>?> getModulesByEvaluationId(int evaluationId) async {
    try {
      List<ModuleEntity> modules =
          await evaluationService.getModulesByEvaluationId(evaluationId);
      return modules;
    } catch (e) {
      print("Error fetching modules for evaluationId $evaluationId: $e");
      return null;
    }
  }

  Future<void> fetchTaskInstancesForModuleInstances(
      List<ModuleInstanceEntity> moduleInstances) async {
    for (var moduleInstance in moduleInstances) {
      print(moduleInstance);
      var tasks = await evaluationService
          .getTasksByModuleId(moduleInstance.moduleInstanceID!);
      if (tasks != null && tasks.isNotEmpty) {
        print("Tasks for module ${moduleInstance.moduleID}: $tasks");
        tasksListDetails.value.add({moduleInstance.moduleID!: tasks});
      } else {
        print("No tasks found for module ${moduleInstance.moduleInstanceID}");
      }
    }
  }

  Future<List<ModuleInstanceEntity>?> getModuleInstancesByEvaluationId(
      int evaluationId) async {
    try {
      List<ModuleInstanceEntity> modules = await evaluationService
          .getModulesInstanceByEvaluationId(evaluationId);
      return modules;
    } catch (e) {
      print("Error fetching modules for evaluationId $evaluationId: $e");
      return null;
    }
  }

  Future<List<TaskInstanceEntity>> getTasks(int moduleId) async {
    var taskInstances = await Get.find<TaskInstanceRepository>()
        .getTaskInstancesForModuleInstance(moduleId);

    return taskInstances;
  }

  Future<void> launchNextTask() async {
    final nextTaskInstance =
        await evaluationService.getFirstPendingTaskInstance();
    if (nextTaskInstance != null) {
      final taskEntity = await nextTaskInstance.task;
      if (taskEntity != null) {
        final taskName = taskEntity.title;
        final taskId = taskEntity.taskID;
        final taskInstanceId = nextTaskInstance.taskInstanceID;

        print("Just Before GetToNamed $taskName, $taskId, $taskInstanceId");

        Get.toNamed(
          AppRoutes.task,
          arguments: {
            RouteArguments.TASK_NAME: taskName,
            RouteArguments.TASK_ID: taskId,
            RouteArguments.TASK_INSTANCE_ID: taskInstanceId,
          },
        );
      }
    }
  }
}

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month &&
          currentDate.day < birthDate.day)) {
    age--;
  }
  return age;
}
