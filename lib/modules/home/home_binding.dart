import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/participant_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/task_repository.dart';
import '../../app/data/datasource/module_local_datasource.dart';
import '../../app/data/datasource/task_local_datasource.dart';
import '../../app/domain/repositories/module_repository.dart';
import '../../app/domain/repositories/participant_repository.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register controller with all required repositories
    Get.lazyPut(() => HomeController());
  }
}
