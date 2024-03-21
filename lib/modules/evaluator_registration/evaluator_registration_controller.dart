import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/evaluator/evaluator_repository.dart';
import '../../constants/enums/person_enums/person_enums.dart';
import '../../constants/route_arguments.dart';
import '../../mixins/ValidationMixin.dart';
import '../evaluators/evaluators_controller.dart';

class EvaluatorRegistrationController extends GetxController with ValidationMixin {
  final EvaluatorRepository _repository;
  final EvaluatorsController _evaluatorsController;

  EvaluatorRegistrationController(this._repository, this._evaluatorsController);

  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final specialtyController = TextEditingController();
  final cpfOrNifController = TextEditingController();
  final usernameController = TextEditingController();
  final RxString username = ''.obs;

  var selectedSex = Rx<Sex?>(null);
  var selectedDate = Rx<DateTime?>(null);
  var isGeneratingUsername = false.obs;
  var isUsernameValid = false.obs;
  final FocusNode fullNameFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  @override
  void onInit() {
    super.onInit();

    EvaluatorEntity? evaluator;

    // Attempt to get the evaluator ID passed as an argument
    // Ensure Get.arguments is not null before accessing it
    if (Get.arguments != null) {

      // Attempt to get the evaluator passed as an argument
      evaluator = Get.arguments[RouteArguments.EVALUATOR];


      // If there's an evaluator, populate form fields
      if (evaluator != null) {
        _populateFieldsWithEvaluatorData(evaluator.evaluatorID!);
      }
    }
    fullNameFocusNode.addListener(() async {
      if (!fullNameFocusNode.hasFocus) {
        final validationResult = validateFullName(fullNameController.text);
        if (validationResult == null) {
          String baseUsername = generateUsername(fullNameController.text, []);
          await checkAndUpdateUsername(baseUsername);
        } else {
          username.value = '';
          isUsernameValid.value = false;
        }
      }
    });
  }

  Future<void> _populateFieldsWithEvaluatorData(int evaluatorId) async {
    try {
      final evaluator = await _repository.getEvaluator(evaluatorId);
      if (evaluator != null) {
        fullNameController.text = '${evaluator.name} ${evaluator.surname}';
        dateOfBirthController.text = DateFormat.yMd().format(evaluator.birthDate);
        specialtyController.text = evaluator.specialty ?? '';
        cpfOrNifController.text = evaluator.cpfOrNif ?? '';
        usernameController.text = evaluator.username;
        selectedSex.value = evaluator.sex;
        selectedDate.value = evaluator.birthDate;

        // Assuming you have methods to set initial values for other fields if needed
      }
    } catch (e) {
      print("Error fetching evaluator data: $e");
    }
  }



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
      username: username.value,
      firstLogin: true,
      password: cpfOrNifController.text,
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

  String generateUsername(String fullName, List<String> existingUsernames) {
    // Split the full name into words
    List<String> words = fullName.split(' ');

    // Take the first word and the last word to form the base username
    String baseUsername = "${words.first.toLowerCase()}_${words.last.toLowerCase()}";

    // Initialize the username with the base form
    String username = baseUsername;
    int counter = 1;

    // If the username exists, append a number and increment until a unique username is found
    while (existingUsernames.contains(username)) {
      username = '${baseUsername}${counter++}';
    }

    return username;
  }

    @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    specialtyController.dispose();
    cpfOrNifController.dispose();
    usernameController.dispose();
    fullNameFocusNode.dispose();
    super.onClose();
  }

  void printFormData() {
    print('Full Name: ${fullNameController.text}');
    print('Date of Birth: ${dateOfBirthController.text}');
    print('Sex: ${selectedSex.value == Sex.male ? 'Male' : 'Female'}');
    print('Specialty: ${specialtyController.text}');
    print('CPF/NIF: ${cpfOrNifController.text}');
    print('Username: ${usernameController.text}');
  }

  Future<void> checkAndUpdateUsername(String baseUsername) async {
    int counter = 2; // Start from 2 since you want to append '2' if the base username exists
    String currentUsername = baseUsername;
    EvaluatorEntity? existingEvaluator;

    // This pattern will match if the username ends with a number
    final numberSuffixPattern = RegExp(r'(\d+)$');

    while (true) {
      existingEvaluator = await _repository.getEvaluatorByUsername(currentUsername);
      if (existingEvaluator != null) {
        // Check if the existing username ends with a number
        final match = numberSuffixPattern.firstMatch(existingEvaluator.username);
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
    isUsernameValid.value = true;
  }


}
