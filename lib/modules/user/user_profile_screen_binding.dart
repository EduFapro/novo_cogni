import 'package:get/get.dart';
import 'package:novo_cogni/modules/user/user_profile_screen_controller.dart';

class UserProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserProfileScreenController(), permanent: true);
  }
}
