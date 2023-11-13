import 'package:get/get.dart';
import 'package:novo_cogni/modules/nova_senha/nova_senha_controller.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/repositories/avaliador_repository.dart';

class NovaSenhaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvaliadorLocalDataSource());
    Get.lazyPut(() => AvaliadorRepository(localDataSource: Get.find()));
    Get.lazyPut(() => NovaSenhaController(
          avaliadorRepository: Get.find<AvaliadorRepository>(),
        ));


  }
}
