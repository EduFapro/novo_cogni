import 'package:get/get.dart';
import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../avaliadores/avaliadores_controller.dart';
import 'cadastro_avaliador_controller.dart';

class CadastroAvaliadorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvaliadorLocalDataSource());
    Get.lazyPut(() => AvaliadorRepository(localDataSource: Get.find()));

    // Ensure AvaliadoresController is available
    Get.find<AvaliadoresController>();

    // Pass AvaliadoresController to CadastroAvaliadorController
    Get.lazyPut(() => CadastroAvaliadorController(Get.find(), Get.find<AvaliadoresController>()));
  }
}

