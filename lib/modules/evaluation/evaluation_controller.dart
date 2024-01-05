import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/evaluation_entity.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/app/domain/entities/participant_entity.dart';

import '../../app/domain/entities/module_instance_entity.dart';
import '../../app/domain/entities/task_instance_entity.dart';
import '../../app/domain/repositories/task_instance_repository.dart';
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
      return 0;
    }
    return DateTime.now().year - participant.value!.birthDate.year;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    // Retrieve and set the arguments
    final arguments = Get.arguments as Map<String, dynamic>;

    if (arguments.containsKey('participant')) {
      participant.value = arguments['participant'];
    }
    if (arguments.containsKey('evaluation')) {
      evaluation.value = arguments['evaluation'];
    }

    if (evaluation.value != null) {
      List<ModuleInstanceEntity>? modules = await getModuleInstancesByEvaluationId(
          evaluation.value!.evaluationID!);
      if (modules != null && modules.isNotEmpty) {
        modulesInstanceList.value = modules;
        await fetchTasksForModules(modules);
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

  Future<void> fetchTasksForModules(List<ModuleInstanceEntity> moduleInstances) async {
    for (var module in moduleInstances) {
      var tasks = await getTasksByModuleId(module.moduleID!);
      if (tasks != null && tasks.isNotEmpty) {
        tasksListDetails.value.add({module.moduleID!: tasks});
      }
    }
  }

  Future<List<TaskInstanceEntity>?> getTasksByModuleId(int moduleId) async {
    try {
      return await evaluationService.getTasksByModuleId(moduleId);
    } catch (e) {
      print('Error fetching tasks for moduleId $moduleId: $e');
      return [];
    }
  }

  Future<List<ModuleInstanceEntity>?> getModuleInstancesByEvaluationId(int evaluationId) async {
    try {
      List<ModuleInstanceEntity> modules =
          await evaluationService.getModulesInstanceByEvaluationId(evaluationId);
      return modules;
    } catch (e) {
      print("Error fetching modules for evaluationId $evaluationId: $e");
      return null;
    }
  }

  Future<List<TaskInstanceEntity>> getTasks(int moduleId) async {
    // This method should return a Future that completes with a list of task instances.
    // It should wait for the task entities to be fetched asynchronously.
    var taskInstances = await Get.find<TaskInstanceRepository>().getTaskInstancesForModuleInstance(moduleId);

    return taskInstances;
  }
}
