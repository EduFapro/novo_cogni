
import 'package:get/get.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvaliadorLocalDataSource>(() => AvaliadorLocalDataSource());
    Get.lazyPut<LoginController>(
            () => LoginController(Get.find<AvaliadorLocalDataSource>())
    );
  }
}
