
import 'package:get/get.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import 'login_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvaliadorLocalDataSource>(() => AvaliadorLocalDataSource());
    Get.lazyPut<LoginScreenController>(
            () => LoginScreenController(Get.find<AvaliadorLocalDataSource>())
    );
  }
}
