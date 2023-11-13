import '../../data/datasource/avaliador_local_datasource.dart';
import '../entities/avaliador_entity.dart';

class AvaliadorRepository {
  final AvaliadorLocalDataSource localDataSource;

  AvaliadorRepository({required this.localDataSource});

  Future<int?> createAvaliador(AvaliadorEntity avaliador) async {
    return await localDataSource.create(avaliador);
  }

  Future<AvaliadorEntity?> getAvaliador(int id) async {
    return await localDataSource.getAvaliador(id);
  }

  Future<int> deleteAvaliador(int id) async {
    return await localDataSource.deleteAvaliador(id);
  }

  Future<int> updateAvaliador(AvaliadorEntity avaliador) async {
    return await localDataSource.updateAvaliador(avaliador);
  }

  Future<List<AvaliadorEntity>> getAllAvaliadores() async {
    try {
      return await localDataSource.getAllAvaliadores();
    } catch (e) {
      print('Error fetching all avaliadores: $e');
      return [];
    }
  }

  Future<int?> getNumeroAvaliadores() async {
    return await localDataSource.getNumeroAvaliadores();
  }
}
