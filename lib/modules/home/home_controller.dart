import 'package:get/get.dart';
import '../../app/domain/entities/evaluation_entity.dart';
import '../../app/domain/entities/evaluator_entity.dart';
import '../../app/domain/entities/participant_entity.dart';
import '../../app/enums/module_enums.dart';
import '../../global/user_controller.dart';

class HomeController extends GetxController {
  final UserController userController = Get.find<UserController>();

  var isLoading = false.obs;
  var user = Rxn<EvaluatorEntity>();
  var evaluations = RxList<EvaluationEntity>();
  var participants = RxList<ParticipantEntity>();
  var participantDetails = RxMap<int, ParticipantEntity>();

  var numEvaluationsInProgress = 0.obs;
  var numEvaluationsFinished = 0.obs;
  var numEvaluationsTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    setupListeners();
    fetchData();
    numEvaluationsTotal.value = evaluations.length;
  }

  void setupListeners() {
    listenToUserChanges();
    listenToEvaluationsChanges();
    listenToParticipantsChanges();
    listenToParticipantDetailsChanges();
  }

  void listenToUserChanges() {
    ever(userController.user, (EvaluatorEntity? newUser) {
      user.value = newUser;
      print("User updated: ${user.value?.name}");
    });
  }

  void listenToEvaluationsChanges() {
    ever(userController.evaluations, (List<EvaluationEntity> newEvaluations) {
      evaluations.assignAll(newEvaluations);
      isLoading.value = newEvaluations.isNotEmpty;
      print("Evaluations updated: ${evaluations.length}");

      // Reset counters
      numEvaluationsInProgress.value = 0;
      numEvaluationsFinished.value = 0;
      numEvaluationsTotal.value = newEvaluations.length;

      // Update counters based on the status of each evaluation
      for (var evaluation in newEvaluations) {
        if (evaluation.status == Status.in_progress) {
          numEvaluationsInProgress.value++;
        } else if (evaluation.status == Status.completed) {
          numEvaluationsFinished.value++;
        }
      }
    });
  }

  void listenToParticipantsChanges() {
    ever(userController.participants, (List<ParticipantEntity> newParticipants) {
      participants.assignAll(newParticipants);
      print("Participants updated: ${participants.length}");
    });
  }

  void listenToParticipantDetailsChanges() {
    ever(userController.participantDetails, (Map<int, ParticipantEntity> newDetails) {
      participantDetails.assignAll(newDetails);
      print("Participant details updated");
    });
  }

  void fetchData() async {
    isLoading.value = true;
    await userController.fetchUserData();
    var currentUser = await userController.getCurrentUserOrFetch();
    if (currentUser != null) {
      user.value = currentUser;
    }
    updateLoadingState();
  }

  void updateLoadingState() {
    isLoading.value = !(user.value != null &&
        evaluations.isNotEmpty &&
        participants.isNotEmpty);
  }

  void addNewParticipant(ParticipantEntity newParticipant, Map<String, int> newParticipantMap) {
    print("Inside HomeController: $newParticipantMap");
    var newParticipantID = newParticipantMap["participanteId"];
    var newEvaluationID = newParticipantMap["avaliacaoId"];
    var evaluatorID = user.value!.evaluatorID;
    print("newParticipantID: $newParticipantID");
    print("newEvaluationID: $newEvaluationID");
    print("EvaluatorID: $evaluatorID");

    print("Adding new participant");

    participants.add(newParticipant);
    participantDetails[newParticipantID!] = newParticipant;

    evaluations.add(EvaluationEntity(
        evaluatorID: evaluatorID!,
        evaluationID: newEvaluationID,
        participantID: newParticipantID));

    // Refresh data to update UI and other dependent components
    // refreshData();
  }

// void refreshData() async {
//   isLoading.value = true;
//
//   fetchData();
//   update();
//
//   isLoading.value = false;
// }
}
