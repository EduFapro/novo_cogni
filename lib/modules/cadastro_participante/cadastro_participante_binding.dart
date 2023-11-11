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
import '../../app/domain/repositories/tarefa_repository.dart';
import 'cadastro_participante_controller.dart';
import 'cadastro_participante_service.dart';

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
    Get.lazyPut<ParticipanteRepository>(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut<AvaliacaoRepository>(() => AvaliacaoRepository(localDataSource: Get.find()));
    Get.lazyPut<ModuloRepository>(() => ModuloRepository(
      moduloLocalDataSource: Get.find(),
      tarefaLocalDataSource: Get.find(),
    ));
    Get.lazyPut<AvaliacaoModuloRepository>(() => AvaliacaoModuloRepository(localDataSource: Get.find()));
    Get.lazyPut<TarefaRepository>(() => TarefaRepository(localDataSource: Get.find()));

    // Register service
    Get.lazyPut<ParticipanteService>(() => ParticipanteService(
      participanteRepository: Get.find<ParticipanteRepository>(),
      avaliacaoRepository: Get.find<AvaliacaoRepository>(),
      moduloRepository: Get.find<ModuloRepository>(),
      avaliacaoModuloRepository: Get.find<AvaliacaoModuloRepository>(),
      tarefaRepository: Get.find<TarefaRepository>(),
    ));

    // Register controller with the service
    Get.lazyPut<CadastroParticipanteController>(() => CadastroParticipanteController(Get.find<ParticipanteService>()));
  }
}
