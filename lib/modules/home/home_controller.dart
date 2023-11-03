import 'package:get/get.dart';

import '../../app/domain/entities/avaliacao_entity.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/entities/participante_entity.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var avaliacoes = <AvaliacaoEntity>[];
  var participantes = <ParticipanteEntity>[];
  var modulos = <ModuloEntity>[];
  var avaliadores = <AvaliadorEntity>[];

  final AvaliadorRepository avaliadorRepository;
  final AvaliacaoRepository avaliacaoRepository;
  final ParticipanteRepository participanteRepository;
  final ModuloRepository moduloRepository;

  HomeController({
    required this.avaliadorRepository,
    required this.avaliacaoRepository,
    required this.participanteRepository,
    required this.moduloRepository,
  });

  @override
  void onInit() {
    super.onInit();
    // Initialization logic here, maybe fetch some data, etc.
    fetchData(); // You should implement this method to populate the lists
  }

  void fetchData() async {
    try {
      isLoading.value = true;

      // Fetch avaliadores, avaliacoes, participantes, and modulos data
      avaliadores = await avaliadorRepository.getAllAvaliadores();
      avaliacoes = await avaliacaoRepository.getAllAvaliacoes();
      participantes = await participanteRepository.getAllParticipantes();
      modulos = await moduloRepository.getAllModulos();

      // Update the state when data is fetched
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      print("Error fetching data: $e");
    }
  }

// Any additional methods that handle UI logic or interact with data goes here
}
