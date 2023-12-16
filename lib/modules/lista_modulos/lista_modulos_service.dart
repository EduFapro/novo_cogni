import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';

import '../../app/domain/entities/avaliacao_modulo_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';

class ListaModulosService {
  final ModuloRepository moduloRepository;
  final AvaliacaoModuloRepository avaliacaoModuloRepository;
  final TarefaRepository tarefaRepository;

  ListaModulosService({
    required this.moduloRepository,
    required this.avaliacaoModuloRepository,
    required this.tarefaRepository
  });

  Future<List<ModuloEntity>> getModulosByAvaliacaoId(int avaliacaoId) async {
    try {
      return await avaliacaoModuloRepository
          .getModulosByAvaliacaoId(avaliacaoId);
    } catch (e) {
      print('Error fetching modulos for avaliacao: $avaliacaoId $e');
      return [];
    }
  }

  Future<List<TarefaEntity>?> getTarefasByModuloId(int moduloId) async {
    try {
      return await tarefaRepository.getTarefasForModulo(moduloId);
    } catch (e) {
      print('Error fetching tarefas for modulo: $moduloId $e');
      return [];
    }
  }

  // Metodos básicos

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

  Future<int?> createAvaliacaoModulo(
      AvaliacaoModuloEntity avaliacaoModulo) async {
    return await avaliacaoModuloRepository
        .createAvaliacaoModulo(avaliacaoModulo);
  }

  // Future<int?> createModulo(ModuloEntity modulo) async {
  //   return await moduloRepository.createModulo(modulo);
  // }
}
