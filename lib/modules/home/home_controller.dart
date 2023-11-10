import 'package:get/get.dart';
import '../../app/domain/entities/avaliacao_entity.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/entities/participante_entity.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';
import '../../app/domain/repositories/tarefa_repository.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var avaliacoes = <AvaliacaoEntity>[].obs;
  var participantes = <ParticipanteEntity>[].obs;
  var modulos = <ModuloEntity>[].obs;
  var avaliadores = <AvaliadorEntity>[].obs;

  final AvaliadorRepository avaliadorRepository;
  final AvaliacaoRepository avaliacaoRepository;
  final ParticipanteRepository participanteRepository;
  final ModuloRepository moduloRepository;
  final TarefaRepository tarefaRepository;

  HomeController({
    required this.avaliadorRepository,
    required this.avaliacaoRepository,
    required this.participanteRepository,
    required this.moduloRepository,
    required this.tarefaRepository,
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

      // Fetch data and assign the results using assignAll
      var fetchedAvaliadores = await avaliadorRepository.getAllAvaliadores();
      avaliadores.assignAll(fetchedAvaliadores);
      print('Avaliadores fetched: ${avaliadores.length}');

      var fetchedAvaliacoes = await avaliacaoRepository.getAllAvaliacoes();
      avaliacoes.assignAll(fetchedAvaliacoes);
      print('Avaliacoes fetched: ${avaliacoes.length}');

      var fetchedParticipantes = await participanteRepository.getAllParticipantes();
      participantes.assignAll(fetchedParticipantes);
      print('Participantes fetched: ${participantes.length}');

      var fetchedModulos = await moduloRepository.getAllModulos();
      modulos.assignAll(fetchedModulos);
      print('Modulos fetched: ${modulos.length}');

      isLoading.value = false;
      print('Data fetched successfully');
    } catch (e) {
      isLoading.value = false;
      print("Error fetching data: $e");
    }
  }

}
