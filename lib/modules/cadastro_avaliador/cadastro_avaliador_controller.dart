import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../../utils/enums/pessoa_enums.dart';

class CadastroAvaliadorController extends GetxController {
  final AvaliadorRepository _repository;

  CadastroAvaliadorController(this._repository);

  final nomeCompletoController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final especialidadeController = TextEditingController();
  final CPF_NIFController = TextEditingController();
  final emailController = TextEditingController();

  var selectedSexo = Rx<Sexo?>(null);
  var selectedDate = Rx<DateTime?>(null);

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

  void createAvaliador() {
    var nomeCompleto = nomeCompletoController.text;
    List<String> parts = nomeCompleto.split(' ');

    var nome = parts.first;
    var sobrenome = parts.skip(1).join(' ');

    DateTime? parsedDate;
    try {
      parsedDate = DateFormat.yMd().parse(dataNascimentoController.text);
    } catch (e) {
      print('Error parsing date: $e');
      return;  // Early return if there's an error
    }

    if (parsedDate == null || selectedSexo.value == null) {
      print('Date or Sexo is null. Aborting.');
      return; // Ensure parsedDate and selectedSexo are not null before proceeding
    }

    AvaliadorEntity novoAvaliador = AvaliadorEntity(
        nome: nome,
        sobrenome: sobrenome,
        dataNascimento: parsedDate,
        sexo: selectedSexo.value!,
        especialidade: especialidadeController.text,
        cpfOuNif: CPF_NIFController.text,
        email: emailController.text, password: '0000'
    );

    _repository.createAvaliador(novoAvaliador);
    // Possibly give some user feedback after creation.
  }


  Future<AvaliadorEntity?> getAvaliador(int id) async {
    return _repository.getAvaliador(id);
  }

  Future<List<AvaliadorEntity>?> getAllAvaliadores() async {
    return _repository.getAllAvaliadores();
  }

  @override
  void onClose() {
    nomeCompletoController.dispose();
    dataNascimentoController.dispose();
    especialidadeController.dispose();
    CPF_NIFController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void printFormData() {
    print('Nome Completo: ${nomeCompletoController.text}');
    print('Data de Nascimento: ${dataNascimentoController.text}');
    print('Sexo: ${selectedSexo == Sexo.homem ? 'Homem' : 'Mulher'}');
    print('Especialidade: ${especialidadeController.text}');
    print('CPF/NIF: ${CPF_NIFController.text}');
    print('Email: ${emailController.text}');
  }
}
