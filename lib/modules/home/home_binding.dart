import 'package:get/get.dart';
import 'package:novo_cogni/app/data/datasource/modulo_local_datasource.dart';
import 'package:novo_cogni/app/data/datasource/participante_local_datasource.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';
import '../../app/data/datasource/tarefa_local_datasource.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ParticipanteLocalDataSource());
    Get.lazyPut(() => ModuloLocalDataSource());
    Get.lazyPut(() => TarefaLocalDataSource());

    // Register repositories with their respective data sources
    Get.lazyPut(() => ParticipanteRepository(localDataSource: Get.find()));
    Get.lazyPut(() => ModuloRepository(
        moduloLocalDataSource: Get.find(), tarefaLocalDataSource: Get.find()));
    Get.lazyPut(() => TarefaRepository(localDataSource: Get.find()));

    // Register controller with all required repositories
    Get.lazyPut(() => HomeController(

        ));
  }
}
