import 'package:novo_cogni/app/domain/entities/task_instance_entity.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/domain/entities/module_entity.dart';
import '../../app/domain/entities/module_instance_entity.dart';
import '../../app/domain/repositories/module_instance_repository.dart';
import '../../app/domain/repositories/module_repository.dart';
import '../../app/domain/repositories/task_instance_repository.dart';

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
      List<TaskInstanceEntity> taskInstanceList = await taskInstanceRepository.getTaskInstancesForModuleInstance(moduleId);

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


}
