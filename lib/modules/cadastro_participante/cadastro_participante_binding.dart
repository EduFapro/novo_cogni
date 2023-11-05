import 'package:get/get.dart';
import '../../app/data/datasource/participante_local_datasource.dart';
import '../../app/data/datasource/avaliacao_local_datasource.dart';
import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/avaliacao_modulo_local_datasource.dart'; // Assuming you have this data source
import '../../app/domain/repositories/participante_repository.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart'; // Assuming you have this repository
import 'cadastro_participante_controller.dart';

class CadastroParticipanteBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ParticipanteLocalDataSource());
    Get.lazyPut(() => AvaliacaoLocalDataSource());
    Get.lazyPut(() => ModuloLocalDataSource());
    Get.lazyPut(() => AvaliacaoModuloLocalDataSource()); // Assuming you have this data source

    // Register repositories with their respective data sources
    Get.lazyPut(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut(() => AvaliacaoRepository(localDataSource: Get.find()));
    Get.lazyPut(() => ModuloRepository(localDataSource: Get.find()));
    Get.lazyPut(() => AvaliacaoModuloRepository(localDataSource: Get.find())); // Assuming you have this repository

    // Register controller with all required repositories
    Get.lazyPut(() => CadastroParticipanteController(
      Get.find<ParticipanteRepository>(),
      Get.find<AvaliacaoRepository>(),
      Get.find<ModuloRepository>(),
      Get.find<AvaliacaoModuloRepository>(),
    ));
  }
}
