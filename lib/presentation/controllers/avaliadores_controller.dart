import 'package:get/get.dart';

import '../../data/datasource/avaliador_local_datasource.dart';
import '../../domain/entities/avaliador_entity.dart';
import '../../domain/repositories/avaliador_repository.dart';

class AvaliadoresController extends GetxController {

  var avaliadoresList = <AvaliadorEntity>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchAvaliadores();
  }

  void fetchAvaliadores() async {
    var avaliadores = await AvaliadorRepository(localDataSource: AvaliadorLocalDataSource()).getAllAvaliadores();
    avaliadoresList.value = avaliadores;
  }

}
