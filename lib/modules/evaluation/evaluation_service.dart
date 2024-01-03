import 'package:novo_cogni/app/domain/entities/task_entity.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/domain/entities/module_entity.dart';
import '../../app/domain/entities/module_instance_entity.dart';
import '../../app/domain/repositories/module_instance_repository.dart';
import '../../app/domain/repositories/module_repository.dart';

class EvaluationService {
  final ModuleRepository moduleRepository;
  final TaskRepository taskRepository;
  final ModuleInstanceRepository moduleInstanceRepository;

  EvaluationService(
      {required this.moduleRepository,
      required this.moduleInstanceRepository,
      required this.taskRepository});

  Future<List<ModuleEntity>> getModulesByEvaluationId(int evaluationId) async {
    try {
      List<ModuleInstanceEntity> moduleInstances = await moduleInstanceRepository.getModuleInstancesByEvaluationId(evaluationId);
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

  Future<List<TaskEntity>?> getTasksByModuleId(int moduleId) async {
    try {
      return await taskRepository.getTasksForModule(moduleId);
    } catch (e) {
      print('Error fetching tasks for module: $moduleId $e');
      return [];
    }
  }



// Future<int?> createModule(ModuleEntity module) async {
//   return await moduleRepository.createModule(module);
// }
}
