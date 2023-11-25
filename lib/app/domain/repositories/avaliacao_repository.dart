import '../../data/datasource/avaliacao_local_datasource.dart';
import '../../domain/entities/avaliacao_entity.dart';

class AvaliacaoRepository {
  final AvaliacaoLocalDataSource localDataSource;

  AvaliacaoRepository({required this.localDataSource});

  // Create an Avaliacao
  Future<int?> createAvaliacao(AvaliacaoEntity avaliacao) async {
    return await localDataSource.create(avaliacao);
  }

  // Get an Avaliacao by ID
  Future<AvaliacaoEntity?> getAvaliacao(int id) async {
    return await localDataSource.getAvaliacao(id);
  }

  // Delete an Avaliacao by ID
  Future<int> deleteAvaliacao(int id) async {
    return await localDataSource.deleteAvaliacao(id);
  }

  // Update an Avaliacao
  Future<int> updateAvaliacao(AvaliacaoEntity avaliacao) async {
    return await localDataSource.updateAvaliacao(avaliacao);
  }

  // Get all Avaliacoes
  Future<List<AvaliacaoEntity>> getAllAvaliacoes() async {
    try {
      return await localDataSource.getAllAvaliacoes();
    } catch (e) {
      print('Error fetching all avaliacoes: $e');
      return [];
    }
  }

  // Get the number of Avaliacoes
  Future<int?> getNumeroAvaliacoes() async {
    return await localDataSource.getNumeroAvaliacoes();
  }


  Future<List<AvaliacaoEntity>> getAvaliacoesByAvaliadorID(int avaliadorID) async {
    return await localDataSource.getAvaliacoesByAvaliadorID(avaliadorID);
  }
}
