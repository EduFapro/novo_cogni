import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/evaluator/evaluator_repository.dart';
import '../../constants/route_arguments.dart';
import '../../constants/translation/ui_messages.dart';
import '../../constants/translation/ui_strings.dart';
import '../../mixins/ValidationMixin.dart';
import '../evaluators/evaluators_controller.dart';

class AdminRegistrationController extends GetxController with ValidationMixin {
  final EvaluatorRepository _repository;
  final EvaluatorsController _evaluatorsController;

  AdminRegistrationController(this._repository, this._evaluatorsController);

  final Rx<EvaluatorEntity?> evaluator = Rxn<EvaluatorEntity>();
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final specialtyController = TextEditingController();
  final cpfOrNifController = TextEditingController();
  final confirmCpfOrNifController = TextEditingController();
  final usernameController = TextEditingController();
  final RxString username = ''.obs;
  final RxString originalUsername = ''.obs;

  final RxBool isPasswordChangeEnabled = false.obs;
  var selectedDate = Rx<DateTime?>(null);
  var isGeneratingUsername = false.obs;
  var isUsernameValid = false.obs;
  final FocusNode fullNameFocusNode = FocusNode();
  final RxBool isUsernameModified = false.obs;

  void resetState() {
    fullNameController.clear();
    dateOfBirthController.clear();
    specialtyController.clear();
    confirmCpfOrNifController.clear();
    cpfOrNifController.clear();
    usernameController.clear();

    username.value = '';
    originalUsername.value = '';
    isPasswordChangeEnabled.value = false;
    selectedDate.value = null;
    isGeneratingUsername.value = false;
    isUsernameValid.value = false;
    isUsernameModified.value = false;

  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    specialtyController.dispose();
    cpfOrNifController.dispose();
    confirmCpfOrNifController.dispose();
    usernameController.dispose();
    fullNameFocusNode.dispose();
    super.onClose();
  }
  @override
  void onInit() {
    super.onInit();

    fullNameFocusNode.addListener(() {
      if (!fullNameFocusNode.hasFocus) {
        final validationResult = validateFullName(fullNameController.text);
        if (validationResult == null) {
          String baseUsername = generateUsername(fullNameController.text, []);
          checkAndUpdateUsername(baseUsername);
        } else {
          username.value = '';
          isUsernameValid.value = false;
        }
      }
    });


  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      selectedDate.value = pickedDate;
    }
  }

  Future<bool> createEvaluator() async {
    var cpf = cpfOrNifController.text;

    // Check if CPF is already registered
    bool cpfExists = await _repository.evaluatorCpfExists(cpf);
    if (cpfExists) {
      Get.snackbar(UiStrings.error, UiMessages.cpfAlreadyInUse);
      return false;
    }

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

    EvaluatorEntity newEvaluator = EvaluatorEntity(
      name: firstName,
      surname: lastName,
      birthDate: parsedDate,
      // sex: selectedSex.value!,
      specialty: specialtyController.text,
      cpfOrNif: cpfOrNifController.text,
      username: username.value,
      firstLogin: true,
      password: cpfOrNifController.text,
      isAdmin: true,
    );

    try {
      // Attempt to create a new evaluator in the database and receive an ID.
      int? evaluatorId = await _repository.createEvaluator(newEvaluator);

      // Use the copyWith method to create a new instance of EvaluatorEntity with the received ID.
      EvaluatorEntity updatedEvaluator =
          newEvaluator.copyWith(evaluatorID: evaluatorId);
      print(updatedEvaluator);
      // Add the updated evaluator to the controller.
      _evaluatorsController.addEvaluator(updatedEvaluator);

      // Return true to indicate success.
      return true;
    } catch (e) {
      // If there's an error, print it and return false.
      print('Error creating evaluator: $e');
      return false;
    }
  }

  String generateUsername(String fullName, List<String> existingUsernames) {
    List<String> words = fullName.split(' ');

    String baseUsername =
        "${words.first.toLowerCase()}_${words.last.toLowerCase()}";
    String username = baseUsername;
    int counter = 1;

    while (existingUsernames.contains(username)) {
      username = '$baseUsername$counter';
      counter++;
    }

    return username;
  }

  void printFormData() {
    print('Full Name: ${fullNameController.text}');
    print('Date of Birth: ${dateOfBirthController.text}');
    // print('Sex: ${selectedSex.value == Sex.male ? 'Male' : 'Female'}');
    print('Specialty: ${specialtyController.text}');
    print('CPF/NIF: ${cpfOrNifController.text}');
    print('Username: ${usernameController.text}');
  }

  Future<void> checkAndUpdateUsername(String baseUsername) async {
    int counter = 2;
    String currentUsername = baseUsername;
    EvaluatorEntity? existingEvaluator;

    // This pattern will match if the username ends with a number
    final numberSuffixPattern = RegExp(r'(\d+)$');

    username.value = currentUsername;
    usernameController.text = currentUsername; // Update the controller

    while (true) {
      existingEvaluator =
          await _repository.getEvaluatorByUsername(currentUsername);
      if (existingEvaluator != null) {
        // Check if the existing username ends with a number
        final match =
            numberSuffixPattern.firstMatch(existingEvaluator.username);
        if (match != null) {
          // If it does, parse the number, increment it, and append to the base username
          final number = int.parse(match.group(1)!);
          currentUsername = '$baseUsername${number + 1}';
        } else {
          // If it doesn't end with a number, simply append '2' or increment counter
          currentUsername = '$baseUsername$counter';
        }
        counter++; // Increment the counter for the next potential loop iteration
      } else {
        break; // Unique username found, exit the loop
      }
    }

    // Found a unique username, update the observable
    username.value = currentUsername;
    usernameController.text = currentUsername; // Update the controller
    isUsernameValid.value = true;
  }

  void togglePasswordVisibility() {
    isPasswordChangeEnabled.value = !isPasswordChangeEnabled.value;
  }

  Future<bool> saveEvaluator() async {

      return createEvaluator();

  }

  Future<bool> updateEvaluator() async {
    print("AIAIAI");
    var cpf = cpfOrNifController.text;
    var evaluatorId = evaluator.value!.evaluatorID!;

    // Check if CPF is registered to another evaluator
    bool cpfExistsForOther =
        await _repository.evaluatorCpfExistsForOther(evaluatorId, cpf);
    if (cpfExistsForOther) {
      Get.snackbar(UiStrings.error, UiMessages.cpfAlreadyInUse);
      return false;
    }

    // Construct the EvaluatorEntity object with updated data
    EvaluatorEntity updatedEvaluator = evaluator.value!.copyWith(
      name: fullNameController.text.split(' ').first,
      surname: fullNameController.text.split(' ').skip(1).join(' '),
      birthDate: selectedDate.value!,
      specialty: specialtyController.text,
      cpfOrNif: cpfOrNifController.text,
      username: usernameController.text,
    );


    print(updatedEvaluator);
    // Attempt to update the evaluator in the database
    int updateCount = await _repository.updateEvaluator(updatedEvaluator);
    if (updateCount == 1) {
      _evaluatorsController.updateEvaluatorInList(updatedEvaluator);
      return true;
    } else {
      // Update failed
      Get.snackbar('Error', 'Failed to update the evaluator.');
      return false;
    }
  }
}
