import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/participante_entity.dart';
import '../../domain/repositories/participante_repository.dart';
import '../../utils/enums/idioma_enums.dart';
import '../../utils/enums/pessoa_enums.dart';

class CadastroParticipanteController extends GetxController {
  final ParticipanteRepository _repository;

  CadastroParticipanteController(this._repository);

  final nomeCompletoController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final escolaridadeController = TextEditingController();
  final dataAvaliacaoController = TextEditingController();

  final selectedSexo = Rx<Sexo?>(null);
  final selectedEscolaridade = Rx<Escolaridade?>(null);
  final selectedDate = Rx<DateTime?>(null);
  final selectedLateralidade = Rx<Lateralidade?>(null);
  final selectedIdioma = Rx<Idioma?>(null);

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

  void createParticipante() {
    var nomeCompleto = nomeCompletoController.text;
    List<String> parts = nomeCompleto.split(' ');

    var nome = parts.first;
    var sobrenome = parts.skip(1).join(' ');

    DateTime? parsedDate =
        DateFormat('yyyy-MM-dd').parse(dataNascimentoController.text);

    ParticipanteEntity novoParticipante = ParticipanteEntity(
      nome: nome,
      sobrenome: sobrenome,
      dataNascimento: parsedDate!,
      sexo: selectedSexo.value!,
      escolaridade: escolaridadeController.text == ''
          ? Escolaridade.fundamental_completo
          : Escolaridade.fundamental_incompleto,
      atividades: [],
    );

    _repository.createParticipante(novoParticipante);
    // Possibly give some user feedback after creation.
  }

  Future<ParticipanteEntity?> getParticipant(int id) async {
    return _repository.getParticipante(id);
  }

  Future<List<ParticipanteEntity>?> getAllParticipantes() async {
    return _repository.getAllParticipantes();
  }

  @override
  void onClose() {
    nomeCompletoController.dispose();
    dataNascimentoController.dispose();
    escolaridadeController.dispose();
    dataAvaliacaoController.dispose();
    super.onClose();
  }

  void printFormData() {
    print('Nome Completo: ${nomeCompletoController.text}');
    print('Data de Nascimento: ${dataNascimentoController.text}');
    print('Sexo: ${selectedSexo.value == Sexo.homem ? 'Homem' : (selectedSexo.value == Sexo.mulher ? 'Mulher' : 'Not Selected')}');
    print('Escolaridade: ${selectedEscolaridade.value?.toString().split('.').last ?? 'Not Selected'}');
    print('Date: ${selectedDate.value?.toIso8601String() ?? 'Not Selected'}');
    print('Lateralidade: ${selectedLateralidade.value?.toString().split('.').last ?? 'Not Selected'}');
    print('Idioma: ${selectedIdioma.value?.toString().split('.').last ?? 'Not Selected'}');
  }

}
