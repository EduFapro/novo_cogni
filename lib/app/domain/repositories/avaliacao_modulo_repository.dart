import '../../data/datasource/avaliacao_modulo_local_datasource.dart';
import '../../domain/entities/avaliacao_modulo_entity.dart';

class AvaliacaoModuloRepository {
  final AvaliacaoModuloLocalDataSource localDataSource;

  AvaliacaoModuloRepository({required this.localDataSource});

  Future<int?> createAvaliacaoModulo(AvaliacaoModuloEntity avaliacaoModulo) async {
    return await localDataSource.createAvaliacaoModulo(
      avaliacaoModulo.avaliacaoId,
      avaliacaoModulo.moduloId,
    );
  }

  Future<AvaliacaoModuloEntity?> getAvaliacaoModulo(int avaliacaoId, int moduloId) async {
    return await localDataSource.getAvaliacaoModulo(avaliacaoId, moduloId);
  }

  Future<int> deleteAvaliacaoModulo(int avaliacaoId, int moduloId) async {
    return await localDataSource.deleteAvaliacaoModulo(avaliacaoId, moduloId);
  }

  Future<int> updateAvaliacaoModulo(AvaliacaoModuloEntity avaliacaoModulo) async {
    return await localDataSource.updateAvaliacaoModulo(avaliacaoModulo);
  }

  Future<List<AvaliacaoModuloEntity>> getAllAvaliacaoModulos() async {
    try {
      return await localDataSource.getAllAvaliacaoModulos();
    } catch (e) {
      print('Error fetching all avaliacao modulos: $e');
      return [];
    }
  }
}
