import 'package:novo_cogni/app/domain/entities/task_entity.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';

import '../../app/domain/entities/module_entity.dart';
import '../../app/domain/repositories/module_repository.dart';

class ModulesListService {
  final ModuleRepository moduleRepository;
  final TaskRepository taskRepository;

  ModulesListService({
    required this.moduleRepository,

    required this.taskRepository
  });

  // Future<List<ModuleEntity>> getModulesByEvaluationId(int evaluationId) async {
  //   try {
  //     return await evaluationModuleRepository
  //         .getModulesByEvaluationId(evaluationId);
  //   } catch (e) {
  //     print('Error fetching modules for evaluation: $evaluationId $e');
  //     return [];
  //   }
  // }

  Future<List<TaskEntity>?> getTasksByModuleId(int moduleId) async {
    try {
      return await taskRepository.getTasksForModule(moduleId);
    } catch (e) {
      print('Error fetching tasks for module: $moduleId $e');
      return [];
    }
  }

  // Basic methods

  Future<ModuleEntity?> getModule(int id) async {
    return await moduleRepository.getModule(id);
  }

  Future<int> deleteModule(int id) async {
    return await moduleRepository.deleteModule(id);
  }

  Future<int> updateModule(ModuleEntity module) async {
    return await moduleRepository.updateModule(module);
  }

  Future<List<ModuleEntity>> getAllModules() async {
    return await moduleRepository.getAllModules();
  }

  Future<ModuleEntity?> getModuleWithTasks(int moduleId) async {
    return await moduleRepository.getModuleWithTasks(moduleId);
  }

  // Future<int?> createEvaluationModule(
  //     EvaluationModuleEntity evaluationModule) async {
  //   return await evaluationModuleRepository
  //       .createEvaluationModule(evaluationModule);
  // }

// Future<int?> createModule(ModuleEntity module) async {
//   return await moduleRepository.createModule(module);
// }
}
