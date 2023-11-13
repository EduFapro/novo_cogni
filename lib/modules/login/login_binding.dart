
import 'package:get/get.dart';
import 'package:novo_cogni/modules/user_avaliador/UserAvaliadorController.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvaliadorLocalDataSource>(() => AvaliadorLocalDataSource());
    Get.lazyPut<UserAvaliadorController>(() => UserAvaliadorController());
    Get.lazyPut<LoginController>(
            () => LoginController(Get.find<AvaliadorLocalDataSource>(), Get.find<UserAvaliadorController>())
    );
  }
}
