import 'package:get/get.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../app/domain/entities/evaluation_entity.dart';
import '../app/domain/entities/evaluator_entity.dart';
import '../app/domain/entities/participant_entity.dart';
import '../app/domain/repositories/evaluator_repository.dart';
import '../app/domain/repositories/participant_repository.dart';

class UserController extends GetxController {
  Rx<EvaluatorEntity?> user = Rxn<EvaluatorEntity>();

  var evaluatorRepo = Get.find<EvaluatorRepository>();
  var userService = Get.find<UserService>();
  var participantRepo = Get.find<ParticipantRepository>();

  var evaluations = <EvaluationEntity>[].obs;
  var participants = <ParticipantEntity>[].obs;
  var participantDetails = <int, ParticipantEntity>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData() async {
    int? currentUserId;

    try {
      currentUserId = user.value?.evaluatorID;
    } catch (e) {
      print("Error retrieving evaluator ID: $e");
      return;
    }

    if (currentUserId == null) {
      print("Current user ID is null");
      return;
    }

    EvaluatorEntity? fetchedUser;
    try {
      fetchedUser = await userService.getUser(currentUserId);
      print("fetched user: $fetchedUser");
    } catch (e) {
      print("Error fetching user data: $e");
      return;
    }

    if (fetchedUser == null) {
      print("Fetched user is null");
      return;
    }

    user.value = fetchedUser;
    List<EvaluationEntity> fetchedEvaluations;
    print("Aqui vamos nós");
    try {
      print("fetched user: $fetchedUser");
      fetchedEvaluations = await userService.getEvaluationsByUser(fetchedUser);
      evaluations.assignAll(fetchedEvaluations);
    } catch (e) {
      print("Error fetching evaluations: $e");
      return;
    }

    for (var evaluation in fetchedEvaluations) {
      try {
        var participant = await participantRepo
            .getParticipantByEvaluation(evaluation.evaluationID!);
        if (participant != null) {
          participants.add(participant);
          participantDetails[evaluation.evaluationID!] = participant;
        }
      } catch (e) {
        print(
            "Error linking participant to evaluation ID ${evaluation.evaluationID}: $e");
      }
    }
  }

  Future<void> updateUser(EvaluatorEntity newUser) async {
    user.value = newUser;
    await fetchUserData();
  }

  Future<EvaluatorEntity?> getCurrentUserOrFetch() async {
    if (user.value == null) {
      await fetchUserData();
    }
    return user.value;
  }
}
