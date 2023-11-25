import 'package:get/get.dart';

import '../../app/domain/entities/avaliacao_entity.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/entities/participante_entity.dart';
import '../../global/user_controller.dart';

class HomeController extends GetxController {
  final UserController userController = Get.find<UserController>();

  var isLoading = false.obs;
  var user = Rxn<AvaliadorEntity>();
  var avaliacoes = RxList<AvaliacaoEntity>();
  var participantes = RxList<ParticipanteEntity>();
  var participanteDetails = RxMap<int, ParticipanteEntity>();

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    setupListeners();
    fetchData();
  }

  void setupListeners() {
    listenToUserChanges();
    listenToAvaliacoesChanges();
    listenToParticipantesChanges();
    listenToParticipanteDetailsChanges();
  }

  void listenToUserChanges() {
    ever(userController.user, (AvaliadorEntity? newUser) {
      user.value = newUser;
      print("User updated: ${user.value?.nome}");
    });
  }

  void listenToAvaliacoesChanges() {
    ever(userController.avaliacoes, (List<AvaliacaoEntity> newAvaliacoes) {
      avaliacoes.assignAll(newAvaliacoes);
      isLoading.value = newAvaliacoes.isNotEmpty;
      print("Avaliacoes updated: ${avaliacoes.length}");
    });
  }

  void listenToParticipantesChanges() {
    ever(userController.participantes,
        (List<ParticipanteEntity> newParticipantes) {
      participantes.assignAll(newParticipantes);
      print("Participantes updated: ${participantes.length}");
    });
  }

  void listenToParticipanteDetailsChanges() {
    ever(userController.participanteDetails,
        (Map<int, ParticipanteEntity> newDetails) {
      participanteDetails.assignAll(newDetails);
      print("Participante details updated");
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

  // void refreshData() async {
  //   // Await the completion of fetchData()
  //   fetchData();
  //
  //   // After fetchData() completes, you can perform additional actions if needed
  //   // For example, you might want to update the UI or trigger other processes
  // }

  void updateLoadingState() {
    isLoading.value = !(user.value != null &&
        avaliacoes.isNotEmpty &&
        participantes.isNotEmpty);
  }

  void addNewParticipante(
      ParticipanteEntity newParticipante, Map<String, int> newParticipanteMap) {
    print("DENTRO DA HOME CONTROLLER: $newParticipanteMap");
    var newParticipanteID = newParticipanteMap["participanteId"];
    var newAvaliacaoID = newParticipanteMap["avaliacaoId"];
    var avaliadorID = user.value!.avaliadorID;
    print("newParticipanteID: $newParticipanteID");
    print("newParticipanteID: $newAvaliacaoID");
    print("AvaliadorID: $avaliadorID");

    print("Adding new participante");

    participantes.add(newParticipante);
    participanteDetails[newParticipanteID!] = newParticipante;

    avaliacoes.add(AvaliacaoEntity(
        avaliadorID: avaliadorID!,
        avaliacaoID: newAvaliacaoID,
        participanteID: newParticipanteID));

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
