import 'package:novo_cogni/app/data/datasource/task_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';

import '../../data/datasource/module_local_datasource.dart';

class ModuleRepository {
  final ModuleLocalDataSource moduleLocalDataSource;
  final TaskLocalDataSource taskLocalDataSource;

  ModuleRepository({required this.moduleLocalDataSource, required this.taskLocalDataSource});

  // Create a Module
  Future<int?> createModule(ModuleEntity module) async {
    return await moduleLocalDataSource.create(module);
  }

  // Get a Module by ID
  Future<ModuleEntity?> getModule(int id) async {
    return await moduleLocalDataSource.getModuleById(id);
  }

  // Delete a Module by ID
  Future<int> deleteModule(int id) async {
    return await moduleLocalDataSource.deleteModule(id);
  }

  // Update a Module
  Future<int> updateModule(ModuleEntity module) async {
    return await moduleLocalDataSource.updateModule(module);
  }

  // Get all Modules
  Future<List<ModuleEntity>> getAllModules() async {
    try {
      return await moduleLocalDataSource.getAllModules();
    } catch (e) {
      print('Error fetching all modules: $e');
      return [];
    }
  }

  // Get a Module with its Tasks
  Future<ModuleEntity?> getModuleWithTasks(int moduleId) async {
    final module = await moduleLocalDataSource.getModuleById(moduleId);
    if (module != null) {
      final tasks = await taskLocalDataSource.getTasksForModule(moduleId);
      module.tasks = tasks;
    }
    return module;
  }

  // Get a Module by Name
  Future<ModuleEntity?> getModuleByName(String name) async {
    try {
      return moduleLocalDataSource.getModuleByName(name);
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Get the number of Modules
  Future<int?> getNumberOfModules() async {
    return await moduleLocalDataSource.getNumberOfModules();
  }
}
