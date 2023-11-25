import 'package:get/get.dart';
import 'package:novo_cogni/global/user_controller.dart';
import 'package:novo_cogni/global/user_service.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';

import '../app/data/datasource/avaliacao_local_datasource.dart';
import '../app/data/datasource/avaliacao_modulo_local_datasource.dart';
import '../app/data/datasource/avaliador_local_datasource.dart';
import '../app/data/datasource/participante_local_datasource.dart';
import '../app/domain/repositories/avaliacao_modulo_repository.dart';
import '../app/domain/repositories/avaliacao_repository.dart';
import '../app/domain/repositories/avaliador_repository.dart';
import '../app/domain/repositories/participante_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources (Lazy Initialization)
    Get.lazyPut<AvaliadorLocalDataSource>(() => AvaliadorLocalDataSource());
    Get.lazyPut<AvaliacaoLocalDataSource>(() => AvaliacaoLocalDataSource());
    Get.lazyPut<ParticipanteLocalDataSource>(() => ParticipanteLocalDataSource());
    Get.lazyPut<AvaliacaoModuloLocalDataSource>(() => AvaliacaoModuloLocalDataSource());

    // Repositories (Lazy Initialization)
    Get.lazyPut<AvaliadorRepository>(() => AvaliadorRepository(
        localDataSource: Get.find<AvaliadorLocalDataSource>()));
    Get.lazyPut<AvaliacaoRepository>(() => AvaliacaoRepository(
        localDataSource: Get.find<AvaliacaoLocalDataSource>()));
    Get.lazyPut<ParticipanteRepository>(() => ParticipanteRepository(
        localDataSource: Get.find<ParticipanteLocalDataSource>()));
    Get.lazyPut<AvaliacaoModuloRepository>(() => AvaliacaoModuloRepository(
        localDataSource: Get.find<AvaliacaoModuloLocalDataSource>()));

    // Core Services (Immediate Initialization)
    Get.put<UserService>(UserService());
    Get.put<UserController>(UserController());
  }
}
