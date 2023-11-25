import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/avaliador_repository.dart';

import '../../app/domain/entities/avaliador_entity.dart';
import '../../global/user_controller.dart';

class LoginController extends GetxController {
  final AvaliadorRepository avaliadorRepository;

  var isLoading = false.obs;
  var loginError = RxString('');
  var currentAvaliadorID = RxInt(0);
  var currentAvaliadorFirstLogin = RxBool(false);
  var userController = Get.find<UserController>();

  LoginController(this.avaliadorRepository);

  Future<bool> logAdmin(String email, String password) async {
    final storedEmail = dotenv.env['EMAIL_ADMIN'];
    final secretKey = dotenv.env['SECRET_KEY'];

    // If the email is the admin's
    if (email == storedEmail) {
      // Hash the entered password
      var bytes = utf8.encode(password);
      var hashedEnteredPassword = sha256.convert(bytes).toString();

      // Hash the stored secret key
      var secretBytes = utf8.encode(secretKey!);
      var hashedStoredPassword = sha256.convert(secretBytes).toString();

      if (hashedEnteredPassword == hashedStoredPassword) {
        return true;
      } else {
        loginError.value = "Invalid admin password";
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      AvaliadorEntity? user =
          await avaliadorRepository.getAvaliadorByEmail(email);
      currentAvaliadorFirstLogin.value = user!.primeiro_login;
      if (user != null && user.password == password) {
        currentAvaliadorID.value = user.avaliadorID!;
        isLoading.value = false;
        userController.updateUser(user);
        return true;
      } else {
        loginError.value = "Invalid credentials";
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      loginError.value = e.toString();
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
