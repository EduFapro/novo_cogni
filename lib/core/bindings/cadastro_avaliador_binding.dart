import 'package:get/get.dart';

import '../../presentation/controllers/cadastro_avaliador_controller.dart';
import '../../data/datasource/avaliador_local_datasource.dart';
import '../../domain/repositories/avaliador_repository.dart';

class CadastroAvaliadorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvaliadorLocalDataSource());
    Get.lazyPut(() => AvaliadorRepository(localDataSource: Get.find()));
    Get.lazyPut(() => CadastroAvaliadorController(Get.find()));
  }
}
