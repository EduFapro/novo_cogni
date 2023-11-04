import 'package:get/get.dart';

import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/repositories/avaliador_repository.dart';

import 'package:get/get.dart';
import '../../app/data/datasource/avaliador_local_datasource.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/repositories/avaliador_repository.dart';

class AvaliadoresController extends GetxController {
  var avaliadoresList = <AvaliadorEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAvaliadores();
  }

  void fetchAvaliadores() async {
    var avaliadores = await AvaliadorRepository(localDataSource: AvaliadorLocalDataSource()).getAllAvaliadores();
    if (avaliadores != null) {
      avaliadoresList.assignAll(avaliadores);
    }
  }

  void addAvaliador(AvaliadorEntity novoAvaliador) {
    avaliadoresList.add(novoAvaliador);
    update(); // Notify the observers of the change
  }
}

