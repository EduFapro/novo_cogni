
import '../../data/datasource/atividade_local_datasource.dart';
import '../../domain/entities/atividade_entity.dart';

class AtividadeRepository {
  final AtividadeLocalDataSource localDataSource;

  AtividadeRepository({required this.localDataSource});

  // Create an Atividade
  Future<int?> createAtividade(AtividadeEntity atividade) async {
    return await localDataSource.create(atividade);
  }

  // Get an Atividade by ID
  Future<AtividadeEntity?> getAtividade(int id) async {
    return await localDataSource.getAtividade(id);
  }

  // Delete an Atividade by ID
  Future<int> deleteAtividade(int id) async {
    return await localDataSource.deleteAtividade(id);
  }

  // Update an Atividade
  Future<int> updateAtividade(AtividadeEntity atividade) async {
    return await localDataSource.updateAtividade(atividade);
  }

  // Get all Atividades
  Future<List<AtividadeEntity>> getAllAtividades() async {
    return await localDataSource.getAllAtividades();
  }

  // Get the number of Atividades
  Future<int?> getNumeroAtividades() async {
    return await localDataSource.getNumeroAtividades();
  }
}
