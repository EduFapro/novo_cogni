import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../app/domain/entities/participante_entity.dart';
import '../../app/enums/idioma_enums.dart';
import '../../app/enums/pessoa_enums.dart';
import 'cadastro_participante_service.dart';

class CadastroParticipanteController extends GetxController {
  final ParticipanteService participanteService;

  CadastroParticipanteController(this.participanteService);

  final nomeCompletoController = TextEditingController();
  final dataNascimentoController = TextEditingController();

  final selectedSexo = Rx<Sexo?>(null);
  final selectedEscolaridade = Rx<Escolaridade?>(null);
  final selectedDate = Rx<DateTime?>(null);
  final selectedLateralidade = Rx<Lateralidade?>(null);
  final selectedIdioma = Rx<Idioma?>(null);

  // Method to select a date using a date picker
  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dataNascimentoController.text = DateFormat.yMd().format(pickedDate);
    }
  }

  // Method to create a new participant and related modules
  Future<bool> createParticipanteAndModulos(int avaliadorID, List<String> selectedActivities) async {
    String nomeCompleto = nomeCompletoController.text;
    DateTime? dataNascimento = selectedDate.value;
    Sexo? sexo = selectedSexo.value;
    Escolaridade? escolaridade = selectedEscolaridade.value;

    ParticipanteEntity novoParticipante = ParticipanteEntity(
      nome: nomeCompleto,
      dataNascimento: dataNascimento!,
      sexo: sexo!,
      escolaridade: escolaridade!,
      sobrenome: '',
    );

    return await participanteService.createParticipanteAndModulos(avaliadorID, selectedActivities, novoParticipante);
  }

  // Method to print form data for debugging purposes
  void printFormData() {
    print("Nome Completo: ${nomeCompletoController.text}");
    print("Data de Nascimento: ${dataNascimentoController.text}");
    print("Sexo: ${selectedSexo.value}");
    print("Escolaridade: ${selectedEscolaridade.value}");
    print("Lateralidade: ${selectedLateralidade.value}");
    print("Idioma: ${selectedIdioma.value}");
    // Add more prints as needed for other fields
  }


  @override
  void onClose() {
    // Dispose of controllers and any other resources
    nomeCompletoController.dispose();
    dataNascimentoController.dispose();
    // Dispose other resources if needed
    super.onClose();
  }
}
