import 'package:get/get.dart';
import 'package:novo_cogni/app/module_instance/module_instance_entity.dart';
import 'package:novo_cogni/app/participant/participant_repository.dart';

import '../app/evaluation/evaluation_entity.dart';
import '../app/evaluation/evaluation_repository.dart';
import '../app/evaluator/evaluator_entity.dart';
import '../app/evaluator/evaluator_repository.dart';
import '../app/module/module_repository.dart';
import '../app/module_instance/module_instance_repository.dart';

class UserService {
  var evaluatorRepo = Get.find<EvaluatorRepository>();
  var evaluationRepo = Get.find<EvaluationRepository>();
  var participantRepo = Get.find<ParticipantRepository>();

  var moduleRepo = Get.find<ModuleRepository>();
  var moduleInstanceRepo = Get.find<ModuleInstanceRepository>();

  Future<EvaluatorEntity?> getUser(int id) async {
    return await evaluatorRepo.getEvaluator(id);
  }

  Future<List<EvaluationEntity>> getEvaluationsByUser(
      EvaluatorEntity user) async {
    var evaluations =
    await evaluationRepo.getEvaluationsByEvaluatorID(user.evaluatorID!);
    return evaluations;
  }

  Future<Map<int, List<ModuleInstanceEntity>>> getModuleMapsForEvaluation(EvaluationEntity evaluation) async {
    // Retrieve all module instances for the given evaluation ID.
    List<ModuleInstanceEntity> moduleInstances = await moduleInstanceRepo.getModuleInstancesByEvaluationId(evaluation.evaluationID!);

    // Initialize an empty map to organize module instances by module ID.
    Map<int, List<ModuleInstanceEntity>> modulesMap = {};

    // Iterate over each module instance.
    for (var instance in moduleInstances) {
      // Check if the module ID is already a key in the map. If not, initialize an empty list.
      modulesMap.putIfAbsent(instance.moduleID, () => []);

      // Add the module instance to the list corresponding to its module ID.
      modulesMap[instance.moduleID]!.add(instance);
    }

    return modulesMap;
  }


}
