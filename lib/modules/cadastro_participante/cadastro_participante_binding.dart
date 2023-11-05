import 'package:get/get.dart';
import '../../app/data/datasource/participante_local_datasource.dart';
import '../../app/data/datasource/avaliacao_local_datasource.dart';
import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/avaliacao_modulo_local_datasource.dart';
import '../../app/data/datasource/tarefa_local_datasource.dart';
import '../../app/domain/repositories/participante_repository.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart';
import 'cadastro_participante_controller.dart';

class CadastroParticipanteBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ParticipanteLocalDataSource());
    Get.lazyPut(() => AvaliacaoLocalDataSource());
    Get.lazyPut(() => ModuloLocalDataSource());
    Get.lazyPut(() => AvaliacaoModuloLocalDataSource());
    Get.lazyPut(() => TarefaLocalDataSource());

    // Register repositories with their respective data sources
    Get.lazyPut(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut(() => AvaliacaoRepository(localDataSource: Get.find()));
    Get.lazyPut(() => ModuloRepository(
          moduloLocalDataSource: Get.find(),
          tarefaLocalDataSource: Get.find(),
        ));
    Get.lazyPut(() => AvaliacaoModuloRepository(localDataSource: Get.find()));

    // Register controller with all required repositories
    Get.lazyPut(() => CadastroParticipanteController(
          Get.find<ParticipanteRepository>(),
          Get.find<AvaliacaoRepository>(),
          Get.find<ModuloRepository>(),
          Get.find<AvaliacaoModuloRepository>(),
        ));
  }
}
