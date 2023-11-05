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
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      print('Fetching data...');

      // Fetch data and log the results
      avaliadores = await avaliadorRepository.getAllAvaliadores();
      print('Avaliadores fetched: ${avaliadores.length}');

      avaliacoes = await avaliacaoRepository.getAllAvaliacoes();
      print('Avaliacoes fetched: ${avaliacoes.length}');

      participantes = await participanteRepository.getAllParticipantes();
      print('Participantes fetched: ${participantes.length}');

      modulos = await moduloRepository.getAllModulos();
      print('Modulos fetched: ${modulos.length}');

      isLoading.value = false;
      print('Data fetched successfully');
      update();
    } catch (e) {
      isLoading.value = false;
      print("Error fetching data: $e");
    }
  }


}
