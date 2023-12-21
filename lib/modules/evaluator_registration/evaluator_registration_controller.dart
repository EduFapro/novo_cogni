import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/domain/entities/evaluator_entity.dart';
import '../../app/domain/repositories/evaluator_repository.dart';
import '../../app/enums/person_enums.dart';
import '../evaluators/evaluators_controller.dart';

class EvaluatorRegistrationController extends GetxController {
  final EvaluatorRepository _repository;
  final EvaluatorsController _evaluatorsController;

  EvaluatorRegistrationController(this._repository, this._evaluatorsController);

  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final specialtyController = TextEditingController();
  final cpfOrNifController = TextEditingController();
  final emailController = TextEditingController();

  var selectedSex = Rx<Sex?>(null);
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
      dateOfBirthController.text = DateFormat.yMd().format(pickedDate);
    }
  }

  Future<bool> createEvaluator() async {
    var fullName = fullNameController.text;
    List<String> parts = fullName.split(' ');

    var firstName = parts.first;
    var lastName = parts.skip(1).join(' ');

    DateTime? parsedDate;
    try {
      parsedDate = DateFormat.yMd().parse(dateOfBirthController.text);
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }

    if (selectedSex.value == null) {
      print('Date or Sex is null. Aborting.');
      return false;
    }

    EvaluatorEntity newEvaluator = EvaluatorEntity(
      name: firstName,
      surname: lastName,
      birthDate: parsedDate,
      sex: selectedSex.value!,
      specialty: specialtyController.text,
      cpfOrNif: cpfOrNifController.text,
      email: emailController.text,
      password: '0000',
      firstLogin: true,
    );

    try {
      await _repository.createEvaluator(newEvaluator);
      _evaluatorsController.addEvaluator(newEvaluator);
      return true;
    } catch (e) {
      print('Error creating evaluator: $e');
      return false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    specialtyController.dispose();
    cpfOrNifController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void printFormData() {
    print('Full Name: ${fullNameController.text}');
    print('Date of Birth: ${dateOfBirthController.text}');
    print('Sex: ${selectedSex.value == Sex.male ? 'Male' : 'Female'}');
    print('Specialty: ${specialtyController.text}');
    print('CPF/NIF: ${cpfOrNifController.text}');
    print('Email: ${emailController.text}');
  }
}
