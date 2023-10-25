
import '../../data/datasource/modulo_local_datasource.dart';
import '../../domain/entities/modulo_entity.dart';

class AtividadeRepository {
  final AtividadeLocalDataSource localDataSource;

  AtividadeRepository({required this.localDataSource});

  // Create an Atividade
  Future<int?> createAtividade(ModuloEntity modulo) async {
    return await localDataSource.create(modulo);
  }

  // Get an Atividade by ID
  Future<ModuloEntity?> getAtividade(int id) async {
    return await localDataSource.getAtividade(id);
  }

  // Delete an Atividade by ID
  Future<int> deleteAtividade(int id) async {
    return await localDataSource.deleteAtividade(id);
  }

  // Update an Atividade
  Future<int> updateAtividade(ModuloEntity modulo) async {
    return await localDataSource.updateAtividade(modulo);
  }

  // Get all Atividades
  Future<List<ModuloEntity>> getAllAtividades() async {
    return await localDataSource.getAllAtividades();
  }

  // Get the number of Atividades
  Future<int?> getNumeroAtividades() async {
    return await localDataSource.getNumeroAtividades();
  }
}
