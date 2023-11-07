import 'package:novo_cogni/app/data/datasource/tarefa_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';

class TarefaRepository {
  final TarefaLocalDataSource localDataSource;

  TarefaRepository({required this.localDataSource});

  // Create a Tarefa
  Future<int?> createTarefa(TarefaEntity tarefa) async {
    return await localDataSource.create(tarefa);
  }

  // Get a Tarefa by ID
  Future<TarefaEntity?> getTarefa(int id) async {
    return await localDataSource.getTarefa(id);
  }

  // Delete a Tarefa by ID
  Future<int> deleteTarefa(int id) async {
    return await localDataSource.deleteTarefa(id);
  }

  // Update a Tarefa
  Future<int> updateTarefa(TarefaEntity tarefa) async {
    return await localDataSource.updateTarefa(tarefa);
  }

  // Get all Tarefas
  Future<List<TarefaEntity>> getAllTarefas() async {
    return await localDataSource.getAllTarefas();
  }

  // Get the number of Tarefas
  Future<int?> getNumeroTarefas() async {
    return await localDataSource.getNumeroTarefas();
  }

  // Close the database
  Future<void> closeDatabase() async {
    await localDataSource.closeDatabase();
  }
}
