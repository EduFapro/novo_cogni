
import '../../data/datasource/modulo_local_datasource.dart';
import '../../domain/entities/modulo_entity.dart';

class ModuloRepository {
  final ModuloLocalDataSource localDataSource;

  ModuloRepository({required this.localDataSource});

  // Create an Modulo
  Future<int?> createModulo(ModuloEntity modulo) async {
    return await localDataSource.create(modulo);
  }

  // Get an Modulo by ID
  Future<ModuloEntity?> getModulo(int id) async {
    return await localDataSource.getModulo(id);
  }

  // Delete an Modulo by ID
  Future<int> deleteModulo(int id) async {
    return await localDataSource.deleteModulo(id);
  }

  // Update an Modulo
  Future<int> updateModulo(ModuloEntity modulo) async {
    return await localDataSource.updateModulo(modulo);
  }

  // Get all Modulos
  Future<List<ModuloEntity>> getAllModulos() async {
    try {
      return await localDataSource.getAllModulos();
    } catch (e) {
      print('Error fetching all avaliacoes: $e');
      return [];
    }
  }

  // Get the number of Modulos
  Future<int?> getNumeroModulos() async {
    return await localDataSource.getNumeroModulos();
  }
}
