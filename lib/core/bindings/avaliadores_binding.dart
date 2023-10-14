import 'package:get/get.dart';
import '../../data/datasource/avaliador_local_datasource.dart';
import '../../domain/repositories/avaliador_repository.dart';
import '../../presentation/controllers/avaliadores_controller.dart';

class AvaliadoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvaliadorLocalDataSource());
    Get.lazyPut(() => AvaliadorRepository(localDataSource: Get.find()));
    Get.lazyPut(() => AvaliadoresController());

  }
}
