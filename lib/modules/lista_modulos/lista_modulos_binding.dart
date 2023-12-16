import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/avaliacao_modulo_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/avaliacao_modulo_repository.dart';
import 'package:novo_cogni/app/domain/repositories/modulo_repository.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';
import 'package:novo_cogni/modules/lista_modulos/lista_modulos_service.dart';

import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/tarefa_local_datasource.dart';
import 'lista_modulos_controller.dart';

class ListaModulosBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ModuloLocalDataSource());
    Get.lazyPut(() => TarefaLocalDataSource());
    Get.lazyPut(() => AvaliacaoModuloLocalDataSource());

    // Register repositories with their respective data sources
    Get.put(
        ModuloRepository(
            moduloLocalDataSource: Get.find(),
            tarefaLocalDataSource: Get.find()),
        permanent: true);
    Get.put(TarefaRepository(localDataSource: Get.find()), permanent: true);
    Get.put(AvaliacaoModuloRepository(localDataSource: Get.find()),
        permanent: true);

    // Other dependencies
    var avaliacaoModuloRepo = Get.find<AvaliacaoModuloRepository>();
    var moduloService = ListaModulosService(
        moduloRepository: Get.find<ModuloRepository>(),
        avaliacaoModuloRepository: avaliacaoModuloRepo, tarefaRepository: Get.find<TarefaRepository>());
    Get.put(moduloService, permanent: true);

    Get.put(
      ListaModulosController(moduloService: moduloService),
      permanent: false,
    );
    // Get.put(
    //   ListaModulosService(
    //       moduloRepository: Get.find<ModuloRepository>(),
    //       avaliacaoModuloRepository: avaliacaoModuloRepo),
    //   permanent: true,
    // );
  }
}
