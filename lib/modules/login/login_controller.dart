import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

import '../../app/seeders/admin_seeder.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/evaluator/evaluator_repository.dart';
import '../../global/user_controller.dart';

class LoginController extends GetxController {
  final EvaluatorRepository evaluatorRepository;

  var isLoading = false.obs;
  var loginError = RxString('');
  var currentEvaluatorId = RxInt(0);
  var currentEvaluatorFirstLogin = RxBool(false);
  var userController = Get.find<UserController>();

  LoginController(this.evaluatorRepository);

  Future<bool> logAdmin(String username, String password) async {
    // If the username is the admin's
    if (username == Config.adminUsername ) {
      // Hash the entered password
      var bytes = utf8.encode(password);
      var hashedEnteredPassword = sha256.convert(bytes).toString();

      // Hash the stored secret key
      var secretBytes = utf8.encode(Config.secretKey!);
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

  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    try {
      EvaluatorEntity? user =
          await evaluatorRepository.getEvaluatorByUsername(username);
      currentEvaluatorFirstLogin.value = user!.firstLogin;
      if (user.password == password) {
        currentEvaluatorId.value = user.evaluatorID!;
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
