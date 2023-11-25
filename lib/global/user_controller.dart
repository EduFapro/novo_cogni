import 'package:get/get.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../app/domain/entities/avaliacao_entity.dart';
import '../app/domain/entities/avaliador_entity.dart';
import '../app/domain/entities/participante_entity.dart';
import '../app/domain/repositories/avaliador_repository.dart';
import '../app/domain/repositories/participante_repository.dart';

class UserController extends GetxController {
  Rx<AvaliadorEntity?> user = Rxn<AvaliadorEntity>();

  var avaliadorRepo = Get.find<AvaliadorRepository>();
  var userService = Get.find<UserService>();
  var participanteRepo = Get.find<ParticipanteRepository>();

  var avaliacoes = <AvaliacaoEntity>[].obs;
  var participantes = <ParticipanteEntity>[].obs;
  var participanteDetails = <int, ParticipanteEntity>{}.obs;


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      int? currentUserId = user.value?.avaliadorID;
      if (currentUserId != null) {
        var fetchedUser = await userService.getUser(currentUserId);
        if (fetchedUser != null) {
          user.value = fetchedUser;
          print("Fetched User: ${user.value}");

          var fetchedAvaliacoes = await userService.getAvaliacoesByUser(fetchedUser);
          avaliacoes.assignAll(fetchedAvaliacoes);
          // print("Fetched Avaliacoes: ${avaliacoes}");

          for (var avaliacao in fetchedAvaliacoes) {
            var participante = await participanteRepo.getParticipanteByAvaliacao(avaliacao.avaliacaoID!);
            if (participante != null) {
              participantes.add(participante);
              participanteDetails[avaliacao.avaliacaoID!] = participante;
              // print("Participante for Avaliacao ID ${avaliacao.avaliacaoID}: $participante");
            }
          }
        }
      } else {
        // print("Current User ID is null");
      }

      print("Fim do try, user: ${user}");
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateUser(AvaliadorEntity newUser) async {
    user.value = newUser;
    await fetchUserData();
  }

  Future<AvaliadorEntity?> getCurrentUserOrFetch() async {
    if (user.value == null) {
      await fetchUserData();
    }
    return user.value;
  }


}
