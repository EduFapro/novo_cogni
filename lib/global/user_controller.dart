import 'package:get/get.dart';
import 'package:novo_cogni/global/user_service.dart';
import '../app/participant/participant_entity.dart';
import '../app/participant/participant_repository.dart';
import '../app/evaluation/evaluation_entity.dart';
import '../app/evaluator/evaluator_entity.dart';
import '../app/evaluator/evaluator_repository.dart';

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
    int? currentUserId = user.value?.evaluatorID;
    if (currentUserId == null) {
      return;
    }

    try {
      print("user: $user");
      var fetchedUser = await userService.getUser(currentUserId);
      if (fetchedUser != null) {
        user.value = fetchedUser;

        var fetchedEvaluations =
            await userService.getEvaluationsByUser(fetchedUser);
        evaluations.assignAll(fetchedEvaluations);

        for (var evaluation in fetchedEvaluations) {
          var participant = await participantRepo
              .getParticipantByEvaluation(evaluation.evaluationID!);
          if (participant != null) {
            participants.add(participant);
            participantDetails[evaluation.evaluationID!] = participant;
          }
        }
      } else {
        print("Fetched user is null");
      }
    } catch (e) {
      print("Error fetching user data: $e");
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

  bool get isUserAdmin {
    return user.value!.isAdmin;
  }

}
