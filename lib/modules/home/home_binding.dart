import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/avaliacao_local_datasource.dart';
import 'package:novo_cogni/app/data/datasource/avaliador_local_datasource.dart';
import 'package:novo_cogni/app/data/datasource/modulo_local_datasource.dart';
import 'package:novo_cogni/app/data/datasource/participante_local_datasource.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvaliadorRepository>(() => AvaliadorRepository(localDataSource: AvaliadorLocalDataSource()));
    Get.lazyPut<AvaliacaoRepository>(() => AvaliacaoRepository(localDataSource: AvaliacaoLocalDataSource()));
    Get.lazyPut<ParticipanteRepository>(() => ParticipanteRepository(localDataSource: ParticipanteLocalDataSource()));
    Get.lazyPut<ModuloRepository>(() => ModuloRepository(localDataSource: ModuloLocalDataSource()));
    Get.lazyPut<HomeController>(() => HomeController(
      avaliadorRepository: Get.find<AvaliadorRepository>(),
      avaliacaoRepository: Get.find<AvaliacaoRepository>(),
      participanteRepository: Get.find<ParticipanteRepository>(),
      moduloRepository: Get.find<ModuloRepository>(),
    ));
  }
}
