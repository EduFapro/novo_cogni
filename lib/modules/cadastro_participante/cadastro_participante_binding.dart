import 'package:get/get.dart';
import '../../app/data/datasource/participante_local_datasource.dart';
import '../../app/domain/repositories/participante_repository.dart';
import 'cadastro_participante_controller.dart';

class CadastroParticipanteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParticipanteLocalDataSource());
    Get.lazyPut(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut(() => CadastroParticipanteController(Get.find()));
  }
}
