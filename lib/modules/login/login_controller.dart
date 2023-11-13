import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/entities/avaliador_entity.dart';

class LoginController extends GetxController {
  final AvaliadorLocalDataSource avaliadorDataSource;
  var isLoading = false.obs;
  var loginError = RxString('');
  var currentAvaliadorID = RxInt(0);
  var currentAvaliadorFirstLogin = RxBool(false);

  LoginController(this.avaliadorDataSource);

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
      AvaliadorEntity? user = await avaliadorDataSource.getAvaliadorByEmail(email);
      currentAvaliadorFirstLogin.value = user!.primeiro_login;
      if (user != null && user.password == password) {
        currentAvaliadorID.value = user.avaliadorID!;
        isLoading.value = false;
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
