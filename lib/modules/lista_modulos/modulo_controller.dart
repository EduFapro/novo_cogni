import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import 'package:novo_cogni/app/domain/entities/participante_entity.dart';
import 'package:novo_cogni/modules/lista_modulos/lista_modulos_service.dart';

class ModuloController extends GetxController {
  final ListaModulosService moduloService;

  var participante = Rx<ParticipanteEntity?>(null);
  var modulo = Rx<ModuloEntity?>(null);

  ModuloController({required this.moduloService});

  int get age {
    if (participante.value?.dataNascimento == null) {
      return 0;
    }
    return DateTime.now().year - participante.value!.dataNascimento.year;
  }

  @override
  void onInit() {
    super.onInit();
    // Retrieve and set the arguments

    final arguments = Get.arguments as Map<String, dynamic>;

    print("-------");
    print(arguments);
    print("-------");

    if (arguments.containsKey('participante')
        // && arguments.containsKey('modulo')
        ) {
      participante.value = arguments['participante'];
      // modulo.value = arguments['modulo'];
      print("Nome: ${participante.value!.nome}");
    } else {
      print("NÃO HÁ CHAVE participante");
    }
  }

  Future<List<ModuloEntity>?> getModulosByAvaliacaoId(int avaliacaoId) async {
    try {
      List<ModuloEntity> modulos =
          await moduloService.getModulosByAvaliacaoId(avaliacaoId);

      return modulos;
    } on Exception catch (e) {
      print(
          "Não foi possível getModulosByAvaliacaoId com avaliacaoId $avaliacaoId");
      print(e);
      return null;
    }
  }
}
