import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/domain/entities/avaliador_entity.dart';
import '../../app/domain/repositories/avaliador_repository.dart';
import '../../app/enums/pessoa_enums.dart';
import '../avaliadores/avaliadores_controller.dart';

class CadastroAvaliadorController extends GetxController {
  final AvaliadorRepository _repository;
  final AvaliadoresController _avaliadoresController;

  CadastroAvaliadorController(this._repository, this._avaliadoresController);


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

  Future<bool> createAvaliador() async {
    var nomeCompleto = nomeCompletoController.text;
    List<String> parts = nomeCompleto.split(' ');

    var nome = parts.first;
    var sobrenome = parts.skip(1).join(' ');

    DateTime? parsedDate;
    try {
      parsedDate = DateFormat.yMd().parse(dataNascimentoController.text);
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }

    if (parsedDate == null || selectedSexo.value == null) {
      print('Date or Sexo is null. Aborting.');
      return false;
    }

    AvaliadorEntity novoAvaliador = AvaliadorEntity(
      nome: nome,
      sobrenome: sobrenome,
      dataNascimento: parsedDate,
      sexo: selectedSexo.value!,
      especialidade: especialidadeController.text,
      cpfOuNif: CPF_NIFController.text,
      email: emailController.text,
      password: '0000',
    );

    try {
      await _repository.createAvaliador(novoAvaliador);
      _avaliadoresController.addAvaliador(novoAvaliador);
      return true;
    } catch (e) {
      print('Error creating avaliador: $e');
      return false;
    }
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
    print('Sexo: ${selectedSexo.value == Sexo.homem ? 'Homem' : 'Mulher'}');
    print('Especialidade: ${especialidadeController.text}');
    print('CPF/NIF: ${CPF_NIFController.text}');
    print('Email: ${emailController.text}');
  }
}
