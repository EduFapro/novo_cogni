import 'package:get/get.dart';
import 'package:novo_cogni/app/module_instance/module_instance_entity.dart';
import 'package:novo_cogni/app/participant/participant_repository.dart';
import 'package:novo_cogni/global/typedefs.dart';

import '../app/evaluation/evaluation_entity.dart';
import '../app/evaluation/evaluation_repository.dart';
import '../app/evaluator/evaluator_entity.dart';
import '../app/evaluator/evaluator_repository.dart';
import '../app/module/module_repository.dart';
import '../app/module_instance/module_instance_repository.dart';
import '../app/participant/participant_entity.dart';
import '../app/task_instance/task_instance_repository.dart';

class UserService extends GetxController {
  var evaluatorRepo = Get.find<EvaluatorRepository>();
  var evaluationRepo = Get.find<EvaluationRepository>();
  var participantRepo = Get.find<ParticipantRepository>();
  var moduleRepo = Get.find<ModuleRepository>();
  var moduleInstanceRepo = Get.find<ModuleInstanceRepository>();
  var taskInstanceRepo = Get.find<TaskInstanceRepository>();

  Rx<EvaluatorEntity?> user = Rxn<EvaluatorEntity>();
  var evaluations = <EvaluationEntity>[].obs;
  var participants = <ParticipantEntity>[].obs;
  var participantDetails = <int, ParticipantEntity>{}.obs;
  var modules = <int, List<ModuleInstanceEntity>>{}.obs;

  bool get isUserAdmin {
    return user.value?.isAdmin ?? false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData(int? currentUserId) async {
    print("PIRIPIPI PÓRÓPÓPÓ");
    if (currentUserId == null) {
      return;
    }

    var fetchedUser = await getUser(currentUserId);
    if (fetchedUser != null) {
      user.value = fetchedUser;
      var userEvaluations = await getEvaluationsByUser(fetchedUser);
      evaluations.assignAll(userEvaluations);

      organizeDataStructure(currentUserId);
    }
  }

  Future<EvaluatorEntity?> getUser(int id) async {
    return await evaluatorRepo.getEvaluator(id);
  }


  Future<EvaluationMap> organizeDataStructure(int userId) async {
    EvaluationMap evaluationMap = {};

    var user = await getUser(userId);
    if (user == null) return evaluationMap;

    var userEvaluations = await getEvaluationsByUser(user);
    for (var evaluation in userEvaluations) {
      ModuleInstanceMap moduleInstanceMap = {};

      var moduleInstances = await getModuleInstancesByEvaluation(evaluation);
      for (var moduleInstance in moduleInstances) {
        var taskInstances = await getTaskInstancesForModuleInstance(moduleInstance);
        moduleInstanceMap[moduleInstance] = taskInstances;
      }

      evaluationMap[evaluation] = moduleInstanceMap;
    }

    return evaluationMap;
  }


  Future<List<EvaluationEntity>> getEvaluationsByUser(
      EvaluatorEntity user) async {
    var evaluations =
        await evaluationRepo.getEvaluationsByEvaluatorID(user.evaluatorID!);
    return evaluations;
  }

  Future<Map<int, List<ModuleInstanceEntity>>> getModuleMapsForEvaluation(
      EvaluationEntity evaluation) async {
    // Retrieve all module instances for the given evaluation ID.
    List<ModuleInstanceEntity> moduleInstances = await moduleInstanceRepo
        .getModuleInstancesByEvaluationId(evaluation.evaluationID!);

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

  Future<List<ModuleInstanceEntity>> getModuleInstancesByEvaluation(
      EvaluationEntity evaluation) async {
    return await moduleInstanceRepo
        .getModuleInstancesByEvaluationId(evaluation.evaluationID!);
  }

  Future<TaskInstanceList> getTaskInstancesForModuleInstance(
      ModuleInstanceEntity moduleInstance) async {
    return await taskInstanceRepo
        .getTaskInstancesByModuleInstanceId(moduleInstance.moduleInstanceID!);
  }

  Future<void> _organizeDataStructure() async {
    var userEvaluations = await getEvaluationsByUser(user.value!);
    evaluations.assignAll(userEvaluations);

    EvaluationMap evaluationMap = {};

    for (var evaluation in userEvaluations) {
      ModuleInstanceMap moduleInstanceMap = {};

      List<ModuleInstanceEntity> moduleInstances =
          await getModuleInstancesByEvaluation(evaluation);
      for (var moduleInstance in moduleInstances) {
        TaskInstanceList taskInstances =
            await getTaskInstancesForModuleInstance(moduleInstance);
        moduleInstanceMap[moduleInstance] = taskInstances;
      }

      evaluationMap[evaluation] = moduleInstanceMap;
    }
  }

  Future<void> updateUser(EvaluatorEntity newUser) async {
    print("DENTRO DA USERSERVICE UPDATEUSER, RECEBIDO: $newUser");
    user.value = newUser;
    await fetchUserData(newUser.evaluatorID);
  }
}
