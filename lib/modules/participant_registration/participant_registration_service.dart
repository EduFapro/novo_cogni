import '../../app/domain/entities/evaluation_entity.dart';
import '../../app/domain/entities/module_entity.dart';
import '../../app/domain/entities/participant_entity.dart';
import '../../app/domain/repositories/evaluation_repository.dart';
import '../../app/domain/repositories/module_repository.dart';
import '../../app/domain/repositories/participant_repository.dart';
import '../../app/domain/repositories/task_repository.dart';

class ParticipantRegistrationService {
  final ParticipantRepository participantRepository;
  final EvaluationRepository evaluationRepository;
  final ModuleRepository moduleRepository;
  final TaskRepository taskRepository;

  ParticipantRegistrationService({
    required this.participantRepository,
    required this.evaluationRepository,
    required this.moduleRepository,
    required this.taskRepository,
  });

  Future<int?> createParticipant(int evaluatorId, List<String> selectedModules,
      ParticipantEntity newParticipant) async {
    int? participantId =
    await participantRepository.createParticipant(newParticipant);
    return participantId;
  }

  Future<int?> createEvaluation(int participantId, int evaluatorId) async {
    EvaluationEntity evaluation = EvaluationEntity(
      participantID: participantId,
      evaluatorID: evaluatorId,
    );

    int? evaluationId = await evaluationRepository.createEvaluation(evaluation);
    return evaluationId;
  }

  Future<List<int>> saveModules(List<ModuleEntity> modules) async {
    List<int> moduleIds = [];
    for (var module in modules) {
      int? id = await moduleRepository.createModule(module);
      if (id != null) {
        moduleIds.add(id);
      }
    }
    return moduleIds;
  }

  Future<void> linkEvaluationToModules(
      int evaluationId, List<int> moduleIds) async {
    for (var moduleId in moduleIds) {

    }
  }

  Future<Map<String, int>> createParticipantAndModules(
      int evaluatorId,
      List<String> selectedModules,
      ParticipantEntity newParticipant) async {

    int? participantId = await createParticipant(
        evaluatorId, selectedModules, newParticipant);
    if (participantId == null) return {};

    print("ID Participante: $participantId");
    int? evaluationId = await createEvaluation(participantId, evaluatorId);
    if (evaluationId == null) return {};
    print("ID Avaliacao: $participantId");
    List<int> moduleIds = await fetchModuleIds(selectedModules);
    await linkEvaluationToModules(evaluationId, moduleIds);

    return {
      "participantId": participantId,
      "evaluationId": evaluationId,
    };
  }

  Future<List<int>> fetchModuleIds(List<String> selectedModules) async {
    print(selectedModules);
    List<Future<int>> futures = selectedModules.map((name) async {
      var module = await moduleRepository.getModuleByName(name);
      return module!.moduleID!;
    }).toList();

    return await Future.wait(futures);
  }
}
