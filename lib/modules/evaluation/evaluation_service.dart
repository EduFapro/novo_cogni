import '../../app/module/module_entity.dart';
import '../../app/module/module_repository.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/module_instance/module_instance_repository.dart';
import '../../app/task/task_repository.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../app/task_instance/task_instance_repository.dart';
import '../../constants/enums/task_enums.dart';

class EvaluationService {
  final ModuleRepository moduleRepository;
  final TaskRepository taskRepository;
  final TaskInstanceRepository taskInstanceRepository;
  final ModuleInstanceRepository moduleInstanceRepository;

  EvaluationService(
      {required this.moduleRepository,
      required this.taskRepository,
      required this.moduleInstanceRepository,
      required this.taskInstanceRepository});

  Future<List<ModuleInstanceEntity>> getModuleInstancesByEvaluationId(int evaluationId) async {
    try {
      // Call the repository to fetch module instances by evaluation ID
      List<ModuleInstanceEntity> moduleInstances = await moduleInstanceRepository.getModuleInstancesByEvaluationId(evaluationId);

      if (moduleInstances.isEmpty) {
        print("No module instances found for evaluation ID: $evaluationId");
      }

      return moduleInstances;
    } catch (e) {
      // Log any errors for debugging
      print('Error fetching module instances for evaluation ID $evaluationId: $e');
      return []; // Return an empty list on error to prevent app crash
    }
  }

  Future<List<ModuleEntity>> getModulesByEvaluationId(int evaluationId) async {
    try {
      List<ModuleInstanceEntity> moduleInstances =
          await moduleInstanceRepository
              .getModuleInstancesByEvaluationId(evaluationId);

      List<ModuleEntity> modules = [];

      for (var moduleInstance in moduleInstances) {
        var module = await moduleRepository.getModule(moduleInstance.moduleID);
        if (module != null) {
          modules.add(module);
        }
      }
      return modules;
    } catch (e) {
      print('Error fetching modules for evaluation: $evaluationId $e');
      return [];
    }
  }

  Future<List<TaskInstanceEntity>?> getTasksByModuleId(int moduleId) async {
    print("moduleId in getTasksByModuleId in eval_service: $moduleId ");
    try {
      List<TaskInstanceEntity> taskInstanceList = await taskInstanceRepository
          .getTaskInstancesForModuleInstance(moduleId);

      return taskInstanceList;
    } catch (e) {
      print('Error fetching tasks for module: $moduleId $e');
      return null;
    }
  }

  Future<List<ModuleInstanceEntity>> getModulesInstanceByEvaluationId(
      int evaluationId) async {
    try {
      List<ModuleInstanceEntity> moduleInstances =
          await moduleInstanceRepository
              .getModuleInstancesByEvaluationId(evaluationId);

      List<ModuleEntity> modules = [];

      for (var moduleInstance in moduleInstances) {
        var module = await moduleRepository.getModule(moduleInstance.moduleID);
        if (module != null) {
          modules.add(module);
        }
      }
      return moduleInstances;
    } catch (e) {
      print('Error fetching modules for evaluation: $evaluationId $e');
      return [];
    }
  }

  Future<TaskInstanceEntity?> getFirstPendingTaskInstance() async {
    try {
      return await taskInstanceRepository.getFirstPendingTaskInstance();
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TaskInstanceEntity?> getNextPendingTaskInstanceForModule(int moduleInstanceId) async {
    try {
      List<TaskInstanceEntity> taskInstances = await taskInstanceRepository.getTaskInstancesForModuleInstance(moduleInstanceId);
      // Directly iterate through taskInstances to find the first with a pending status.
      for (TaskInstanceEntity taskInstance in taskInstances) {
        if (taskInstance.status == TaskStatus.pending) {
          return taskInstance; // Immediately return the first pending task instance found.
        }
      }
      // If no pending task instances are found, explicitly return null.
      return null;
    } catch (e) {
      print('Error fetching next pending task instance for module instance ID $moduleInstanceId: $e');
      return null; // Return null if there is an error or no pending tasks are found.
    }
  }



}
