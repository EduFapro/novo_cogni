import 'package:get/get.dart';

import '../../app/domain/repositories/avaliador_repository.dart';

class NovaSenhaController extends GetxController {
  late bool firstLogin;
  late int avaliadorID;

  final AvaliadorRepository avaliadorRepository;

  NovaSenhaController({required this.avaliadorRepository});

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    firstLogin = arguments['firstLogin'];
    avaliadorID = arguments['avaliadorID'];
  }

  Future<void> changePassword(String newPassword) async {
    var fetchedAvaliador = await avaliadorRepository.getAvaliador(avaliadorID);
    if (fetchedAvaliador != null) {
      fetchedAvaliador.password = newPassword;
      fetchedAvaliador.primeiro_login = false;

      await avaliadorRepository.updateAvaliador(fetchedAvaliador);
    }
  }
}
