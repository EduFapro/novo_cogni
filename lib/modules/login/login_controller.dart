import 'package:get/get.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../../app/evaluator/evaluator_entity.dart';
import '../../app/evaluator/evaluator_repository.dart';
import '../../global/user_controller.dart';

class LoginController extends GetxController {
  final EvaluatorRepository evaluatorRepository;

  var isLoading = false.obs;
  var loginError = RxString('');
  var currentEvaluator = Rx<EvaluatorEntity?>(null);
  var currentEvaluatorFirstLogin = RxBool(false);
  var userService = Get.find<UserService>();

  LoginController(this.evaluatorRepository);


  Future<bool> login(String username, String password) async {
    isLoading.value = true;
    try {
      EvaluatorEntity? user =
          await evaluatorRepository.getEvaluatorByUsername(username);
      // print("Resultado evaluatorRepository.getEvaluatorByUsername: $username");
      currentEvaluatorFirstLogin.value = user!.firstLogin;
      if (user.password == password) {
        currentEvaluator.value = user;
        isLoading.value = false;
        // print("chamando userService.updateUser com $user");
        userService.updateUser(user);
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
