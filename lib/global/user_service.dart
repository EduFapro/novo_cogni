import 'package:get/get.dart';
import 'package:novo_cogni/app/participant/participant_repository.dart';

import '../app/evaluation/evaluation_entity.dart';
import '../app/evaluation/evaluation_repository.dart';
import '../app/evaluator/evaluator_entity.dart';
import '../app/evaluator/evaluator_repository.dart';

class UserService {

  var evaluatorRepo = Get.find<EvaluatorRepository>();
  var evaluationRepo = Get.find<EvaluationRepository>();
  var participantRepo = Get.find<ParticipantRepository>();

  Future<EvaluatorEntity?> getUser(int id) async {
    return await evaluatorRepo.getEvaluator(id);
  }

  Future<List<EvaluationEntity>> getEvaluationsByUser(EvaluatorEntity user) async {
    var evaluations = await evaluationRepo.getEvaluationsByEvaluatorID(user.evaluatorID!);
    return evaluations;
  }

}
