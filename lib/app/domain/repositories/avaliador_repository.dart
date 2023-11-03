import '../../data/datasource/avaliador_local_datasource.dart';
import '../entities/avaliador_entity.dart';

class AvaliadorRepository {
  final AvaliadorLocalDataSource localDataSource;

  AvaliadorRepository({required this.localDataSource});

  // Create an Avaliador
  Future<int?> createAvaliador(AvaliadorEntity avaliador) async {
    return await localDataSource.create(avaliador);
  }

  // Get an Avaliador by ID
  Future<AvaliadorEntity?> getAvaliador(int id) async {
    return await localDataSource.getAvaliador(id);
  }

  // Delete an Avaliador by ID
  Future<int> deleteAvaliador(int id) async {
    return await localDataSource.deleteAvaliador(id);
  }

  // Update an Avaliador
  Future<int> updateAvaliador(AvaliadorEntity avaliador) async {
    return await localDataSource.updateAvaliador(avaliador);
  }

  // Get all Avaliadores
  Future<List<AvaliadorEntity>> getAllAvaliadores() async {
    try {
      return await localDataSource.getAllAvaliadores();
    } catch (e) {
      print('Error fetching all avaliadores: $e');
      return [];
    }
  }

  // Get the number of Avaliadores
  Future<int?> getNumeroAvaliadores() async {
    return await localDataSource.getNumeroAvaliadores();
  }
}
