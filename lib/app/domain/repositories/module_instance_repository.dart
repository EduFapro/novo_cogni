import 'package:novo_cogni/app/data/datasource/module_instance_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/module_instance_entity.dart';

class ModuleInstanceRepository {
  final ModuleInstanceLocalDataSource moduleInstanceLocalDataSource;

  ModuleInstanceRepository({required this.moduleInstanceLocalDataSource});

  // Create a Module Instance
  Future<int?> createModuleInstance(ModuleInstanceEntity moduleInstance) async {
    return await moduleInstanceLocalDataSource.create(moduleInstance);
  }

  // Get a Module Instance by ID
  Future<ModuleInstanceEntity?> getModuleInstance(int id) async {
    return await moduleInstanceLocalDataSource.getModuleInstanceById(id);
  }

  // Delete a Module Instance by ID
  Future<int> deleteModuleInstance(int id) async {
    return await moduleInstanceLocalDataSource.deleteModuleInstance(id);
  }

  // Update a Module Instance
  Future<int> updateModuleInstance(ModuleInstanceEntity moduleInstance) async {
    return await moduleInstanceLocalDataSource.updateModuleInstance(moduleInstance);
  }

  // Get all Module Instances
  Future<List<ModuleInstanceEntity>> getAllModuleInstances() async {
    try {
      return await moduleInstanceLocalDataSource.getAllModuleInstances();
    } catch (e) {
      print('Error fetching all module instances: $e');
      return [];
    }
  }

  // Get the number of Module Instances
  Future<int?> getNumberOfModuleInstances() async {
    return await moduleInstanceLocalDataSource.getNumberOfModuleInstances();
  }
}
