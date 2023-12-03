import '../../app/domain/entities/avaliacao_modulo_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';

class ModuloService {
  final ModuloRepository moduloRepository;
  final AvaliacaoModuloRepository avaliacaoModuloRepository;

  ModuloService({
    required this.moduloRepository,
    required this.avaliacaoModuloRepository,
  });

  Future<int?> createModulo(ModuloEntity modulo) async {
    return await moduloRepository.createModulo(modulo);
  }

  Future<ModuloEntity?> getModulo(int id) async {
    return await moduloRepository.getModulo(id);
  }

  Future<int> deleteModulo(int id) async {
    return await moduloRepository.deleteModulo(id);
  }

  Future<int> updateModulo(ModuloEntity modulo) async {
    return await moduloRepository.updateModulo(modulo);
  }

  Future<List<ModuloEntity>> getAllModulos() async {
    return await moduloRepository.getAllModulos();
  }

  Future<ModuloEntity?> getModuloWithTarefas(int moduloId) async {
    return await moduloRepository.getModuloWithTarefas(moduloId);
  }



  Future<int?> createAvaliacaoModulo(AvaliacaoModuloEntity avaliacaoModulo) async {
    return await avaliacaoModuloRepository.createAvaliacaoModulo(avaliacaoModulo);
  }


}
