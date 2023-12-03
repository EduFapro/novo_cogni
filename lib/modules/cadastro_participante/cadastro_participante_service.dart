import '../../app/domain/entities/avaliacao_entity.dart';
import '../../app/domain/entities/avaliacao_modulo_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/entities/participante_entity.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';
import '../../app/domain/repositories/tarefa_repository.dart';

class ParticipanteService {
  final ParticipanteRepository participanteRepository;
  final AvaliacaoRepository avaliacaoRepository;
  final ModuloRepository moduloRepository;
  final TarefaRepository tarefaRepository;
  final AvaliacaoModuloRepository avaliacaoModuloRepository;

  ParticipanteService({
    required this.participanteRepository,
    required this.avaliacaoRepository,
    required this.moduloRepository,
    required this.avaliacaoModuloRepository,
    required this.tarefaRepository,
  });

  Future<int?> createParticipante(int avaliadorID, List<String> selectedModulos, ParticipanteEntity novoParticipante) async {
    int? participanteId = await participanteRepository.createParticipante(novoParticipante);
    if (participanteId != null) {
      // Additional logic if needed when participanteId is not null
    }
    return participanteId;
  }


  Future<int?> createAvaliacao(int participanteID, int avaliadorID) async {
    AvaliacaoEntity avaliacao = AvaliacaoEntity(
      participanteID: participanteID,
      avaliadorID: avaliadorID,
      // Add other necessary fields and initializations
    );

    int? avaliacaoId = await avaliacaoRepository.createAvaliacao(avaliacao);
    return avaliacaoId;
  }


  Future<List<ModuloEntity>> createModulosEntities(List<String> selectedActivities) async {
    // Logic to create module entities
    List<ModuloEntity> modulos = selectedActivities.map((activity) {
      // Convert each activity to a ModuloEntity
      return ModuloEntity(titulo: "hahahah");
    }).toList();
    return modulos;
  }

  Future<List<int>> saveModulos(List<ModuloEntity> modulos) async {
    List<int> moduloIds = [];
    for (var modulo in modulos) {
      int? id = await moduloRepository.createModulo(modulo);
      if (id != null) {
        moduloIds.add(id);
      }
    }
    return moduloIds;
  }


  Future<void> linkAvaliacaoToModulos(int avaliacaoId, List<int> moduloIds) async {
    for (var moduloId in moduloIds) {
      AvaliacaoModuloEntity avaliacaoModulo = AvaliacaoModuloEntity(
        avaliacaoId: avaliacaoId,
        moduloId: moduloId,
        // Add other necessary fields and initializations
      );

      // Assuming you have a method in the AvaliacaoModuloRepository to create an AvaliacaoModuloEntity
      await avaliacaoModuloRepository.createAvaliacaoModulo(avaliacaoModulo);
    }
  }


  Future<Map<String, int>> createParticipanteAndModulos(int avaliadorID, List<String> selectedActivities, ParticipanteEntity novoParticipante) async {
    // Orchestrating method to create participant and related entities
    int? participanteId = await createParticipante(avaliadorID, selectedActivities, novoParticipante);
    if (participanteId == null) return {};

    int? avaliacaoId = await createAvaliacao(participanteId, avaliadorID);
    if (avaliacaoId == null) return {};

    List<ModuloEntity> modulos = await createModulosEntities(selectedActivities);
    List<int> moduloIds = await saveModulos(modulos);

    await linkAvaliacaoToModulos(avaliacaoId, moduloIds);

    return {
      "participanteId": participanteId,
      "avaliacaoId": avaliacaoId,
    };
  }
}
