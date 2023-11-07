import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import 'package:novo_cogni/app/domain/entities/participante_entity.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';

class ModuloController extends GetxController {
  final ModuloRepository moduloRepository;
  final TarefaRepository tarefaRepository;
  var participante = Rx<ParticipanteEntity?>(null);
  var modulo = Rx<ModuloEntity?>(null);

  ModuloController({required this.moduloRepository, required this.tarefaRepository});

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
    if (arguments.containsKey('participante') && arguments.containsKey('modulo')) {
      participante.value = arguments['participante'];
      modulo.value = arguments['modulo'];
    } else {
      // Handle the case where arguments are not passed or are incorrect
    }
  }
}
