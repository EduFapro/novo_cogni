import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/avaliacao_entity.dart';
import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import 'package:novo_cogni/app/domain/entities/participante_entity.dart';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import 'package:novo_cogni/modules/lista_modulos/lista_modulos_service.dart';

class ListaModulosController extends GetxController {
  final ListaModulosService moduloService;

  var participante = Rx<ParticipanteEntity?>(null);
  var avaliacao = Rx<AvaliacaoEntity?>(null);
  var listaModulos = Rx<List<ModuloEntity?>?>(null);
  var listaTarefasDetails = Rx<List<Map<int, List<TarefaEntity>>>>([]);

var isLoading = false.obs;

  ListaModulosController({required this.moduloService});

  int get age {
    if (participante.value?.dataNascimento == null) {
      return 0;
    }
    return DateTime.now().year - participante.value!.dataNascimento.year;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true; 
    // Retrieve and set the arguments
    final arguments = Get.arguments as Map<String, dynamic>;

    if (arguments.containsKey('participante')) {
      participante.value = arguments['participante'];
    }
    if (arguments.containsKey('avaliacao')) {
      avaliacao.value = arguments['avaliacao'];
    }

    if (avaliacao.value != null) {
    var modulos = await getModulosByAvaliacaoId(avaliacao.value!.avaliacaoID!);
    if (modulos != null && modulos.isNotEmpty) {
      listaModulos.value = modulos;
      await fetchTarefasForModulos(modulos);
    }
  }
    isLoading.value = false;
  }

  Future<List<ModuloEntity>?> getModulosByAvaliacaoId(int avaliacaoId) async {
    try {
      List<ModuloEntity> modulos = await moduloService.getModulosByAvaliacaoId(avaliacaoId);
      return modulos;
    } catch (e) {
      print("Error fetching modulos for avaliacaoId $avaliacaoId: $e");
      return null;
    }
  }

  Future<void> fetchTarefasForModulos(List<ModuloEntity> modulos) async {
    for (var modulo in modulos) {
      var tarefas = await getTarefasByModuloId(modulo.moduloID!);
      if (tarefas != null && tarefas.isNotEmpty) {
        listaTarefasDetails.value.add({modulo.moduloID!: tarefas});
      }
    }
  }

  Future<List<TarefaEntity>?> getTarefasByModuloId(int moduloId) async {
    try {
      return await moduloService.getTarefasByModuloId(moduloId);
    } catch (e) {
      print('Error fetching tarefas for moduloId $moduloId: $e');
      return [];
    }
  }
}
