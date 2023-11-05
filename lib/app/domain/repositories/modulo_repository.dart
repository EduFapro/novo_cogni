
import 'package:novo_cogni/app/data/datasource/tarefa_local_datasource.dart';

import '../../data/datasource/modulo_local_datasource.dart';
import '../../domain/entities/modulo_entity.dart';

class ModuloRepository {
  final ModuloLocalDataSource moduloLocalDataSource;
  final TarefaLocalDataSource  tarefaLocalDataSource;

  ModuloRepository({required this.moduloLocalDataSource, required this.tarefaLocalDataSource});




  // Create an Modulo
  Future<int?> createModulo(ModuloEntity modulo) async {
    return await moduloLocalDataSource.create(modulo);
  }

  // Get an Modulo by ID
  Future<ModuloEntity?> getModulo(int id) async {
    return await moduloLocalDataSource.getModulo(id);
  }

  // Delete an Modulo by ID
  Future<int> deleteModulo(int id) async {
    return await moduloLocalDataSource.deleteModulo(id);
  }

  // Update an Modulo
  Future<int> updateModulo(ModuloEntity modulo) async {
    return await moduloLocalDataSource.updateModulo(modulo);
  }

  // Get all Modulos
  Future<List<ModuloEntity>> getAllModulos() async {
    try {
      return await moduloLocalDataSource.getAllModulos();
    } catch (e) {
      print('Error fetching all avaliacoes: $e');
      return [];
    }
  }

  Future<ModuloEntity?> getModuloWithTarefas(int moduloId) async {
    final modulo = await moduloLocalDataSource.getModulo(moduloId);
    if (modulo != null) {
      final tarefas = await tarefaLocalDataSource.getTarefasForModulo(moduloId);
      modulo.tarefas = tarefas;
    }
    return modulo;
  }


  // Get the number of Modulos
  Future<int?> getNumeroModulos() async {
    return await moduloLocalDataSource.getNumeroModulos();
  }
}
