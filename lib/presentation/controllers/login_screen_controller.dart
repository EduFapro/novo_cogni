import 'package:get/get.dart';
import '../../domain/entities/avaliador_entity.dart';
import '../../data/datasource/avaliador_local_datasource.dart';

class LoginScreenController extends GetxController {
  final AvaliadorLocalDataSource avaliadorDataSource;
  var isLoading = false.obs;
  var loginError = RxString('');


  LoginScreenController(this.avaliadorDataSource);

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      AvaliadorEntity? user = await avaliadorDataSource.getAvaliadorByEmail(email);
      if (user != null && user.password == password) { // Assuming you have a password field in AvaliadorEntity
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
