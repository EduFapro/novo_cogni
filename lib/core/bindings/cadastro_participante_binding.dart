import 'package:get/get.dart';
import '../../data/datasource/participante_local_datasource.dart';
import '../../domain/repositories/participante_repository.dart';
import '../../presentation/controllers/cadastro_participante_controller.dart';

class CadastroParticipanteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParticipanteLocalDataSource());
    Get.lazyPut(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut(() => CadastroParticipanteController(Get.find()));
  }
}
