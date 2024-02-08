import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/app/domain/repositories/evaluation_repository.dart';
import 'package:novo_cogni/app/domain/repositories/evaluator_repository.dart';
import 'package:novo_cogni/app/domain/entities/evaluation_entity.dart';
import 'package:novo_cogni/app/domain/entities/evaluator_entity.dart';
import 'package:novo_cogni/app/domain/repositories/participant_repository.dart';

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
