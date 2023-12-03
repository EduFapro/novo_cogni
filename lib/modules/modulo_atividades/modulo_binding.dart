import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/repositories/avaliacao_modulo_repository.dart';
import 'package:novo_cogni/app/domain/repositories/modulo_repository.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';
import 'package:novo_cogni/modules/modulo_atividades/modulo_service.dart';

import '../../app/data/datasource/modulo_local_datasource.dart';
import '../../app/data/datasource/tarefa_local_datasource.dart';
import 'modulo_controller.dart';

class ModuloBinding extends Bindings {
  @override
  void dependencies() {
    // Register data sources
    Get.lazyPut(() => ModuloLocalDataSource());
    Get.lazyPut(() => TarefaLocalDataSource());

    // Register repositories with their respective data sources
    Get.put(
        ModuloRepository(moduloLocalDataSource: Get.find(), tarefaLocalDataSource: Get.find()),
        permanent: true
    );
    Get.put(
        TarefaRepository(localDataSource: Get.find()),
        permanent: true
    );

    // Other dependencies
    var avaliacaoModuloRepo = Get.find<AvaliacaoModuloRepository>();

    Get.put(
      ModuloController(
        moduloRepository: Get.find<ModuloRepository>(),
        tarefaRepository: Get.find<TarefaRepository>(),
      ),
      permanent: true,
    );
    Get.put(
      ModuloService(
          moduloRepository: Get.find<ModuloRepository>(),
          avaliacaoModuloRepository: avaliacaoModuloRepo
      ),
      permanent: true,
    );
  }
}


