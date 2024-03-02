import 'package:get/get.dart';

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
