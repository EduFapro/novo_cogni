import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/evaluation_entity.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/app/domain/entities/participant_entity.dart';
import 'package:novo_cogni/app/domain/entities/task_entity.dart';

import 'evaluation_service.dart';

class EvaluationController extends GetxController {
  final EvaluationService moduleService;

  var participant = Rx<ParticipantEntity?>(null);
  var evaluation = Rx<EvaluationEntity?>(null);
  var modulesList = Rx<List<ModuleEntity?>?>(null);
  var tasksListDetails = Rx<List<Map<int, List<TaskEntity>>>>([]);

  var isLoading = false.obs;

  EvaluationController({required this.moduleService});

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
      var modules = await getModulesByEvaluationId(evaluation.value!.evaluationID!);
      if (modules != null && modules.isNotEmpty) {
        modulesList.value = modules;
        await fetchTasksForModules(modules);
      }
    }
    isLoading.value = false;
  }

  Future<List<ModuleEntity>?> getModulesByEvaluationId(int evaluationId) async {
    try {
      List<ModuleEntity> modules = await moduleService.getModulesByEvaluationId(evaluationId);
      return modules;
    } catch (e) {
      print("Error fetching modules for evaluationId $evaluationId: $e");
      return null;
    }
  }

  Future<void> fetchTasksForModules(List<ModuleEntity> modules) async {
    for (var module in modules) {
      var tasks = await getTasksByModuleId(module.moduleID!);
      if (tasks != null && tasks.isNotEmpty) {
        tasksListDetails.value.add({module.moduleID!: tasks});
      }
    }
  }

  Future<List<TaskEntity>?> getTasksByModuleId(int moduleId) async {
    try {
      return await moduleService.getTasksByModuleId(moduleId);
    } catch (e) {
      print('Error fetching tasks for moduleId $moduleId: $e');
      return [];
    }
  }
}
