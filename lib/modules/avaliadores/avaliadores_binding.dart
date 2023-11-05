import 'package:get/get.dart';
import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import 'avaliadores_controller.dart';

class AvaliadoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AvaliadorLocalDataSource());
    Get.lazyPut(() => AvaliadorRepository(localDataSource: Get.find()));
    Get.put(AvaliadoresController(), permanent: true);


  }
}
