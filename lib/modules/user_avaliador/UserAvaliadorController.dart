import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/avaliador_entity.dart';

import '../../app/enums/pessoa_enums.dart';

class UserAvaliadorController extends GetxController {
  Rx<AvaliadorEntity> _user = AvaliadorEntity(
          nome: 'nome',
          sobrenome: 'sobrenome',
          dataNascimento: DateTime(1),
          sexo: Sexo.homem,
          especialidade: "",
          cpfOuNif: "",
          email: "",
          password: "",
          primeiro_login: false)
      .obs;

  // Getter for user
  AvaliadorEntity get user => _user.value;

  // Method to update user data
  void updateUser(AvaliadorEntity newUser) {
    _user.value = newUser;
  }

  // Initialize user data, if needed
  @override
  void onInit() {
    super.onInit();
    // Fetch user data or perform other initialization tasks
  }

// Other user-related methods...
}
