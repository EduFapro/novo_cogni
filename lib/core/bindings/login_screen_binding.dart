import 'package:get/get.dart';
import '../../presentation/controllers/login_screen_controller.dart';
import '../../data/datasource/avaliador_local_datasource.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvaliadorLocalDataSource>(() => AvaliadorLocalDataSource());
    Get.lazyPut<LoginScreenController>(
            () => LoginScreenController(Get.find<AvaliadorLocalDataSource>())
    );
  }
}
