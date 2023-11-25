import '../../data/datasource/avaliacao_modulo_local_datasource.dart';
import '../../domain/entities/avaliacao_modulo_entity.dart';
import '../entities/avaliacao_entity.dart';
import '../entities/modulo_entity.dart';

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

  Future<List<ModuloEntity>> getModulosByAvaliacaoId(int avaliacaoId) async {
    try {
      return await localDataSource.getModulosByAvaliacaoId(avaliacaoId);
    } catch (e) {
      print('Error fetching modulos for avaliacao: $e');
      return [];
    }
  }

  Future<List<AvaliacaoEntity>> getAvaliacoesByModuloId(int moduloId) async {
    try {
      return await localDataSource.getAvaliacoesByModuloId(moduloId);
    } catch (e) {
      print('Error fetching avaliacoes for modulo: $e');
      return [];
    }
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
