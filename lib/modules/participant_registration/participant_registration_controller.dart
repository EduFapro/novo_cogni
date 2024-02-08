import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../app/domain/entities/participant_entity.dart';
import '../../app/domain/seeders/modules_seeder.dart';
import '../../constants/enums/person_enums/person_enums.dart';
import '../../constants/enums/language_enums.dart';
import '../home/home_controller.dart';
import 'participant_registration_service.dart';

class ParticipantRegistrationController extends GetxController {
  final ParticipantRegistrationService participantService;

  ParticipantRegistrationController(this.participantService);

  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();

  final selectedSex = Rx<Sex?>(null);
  final selectedEducationLevel = Rx<EducationLevel?>(null);
  final selectedDate = Rx<DateTime?>(null);
  final selectedLaterality = Rx<Handedness?>(null);
  final selectedLanguage = Rx<Language?>(null);

  final RxMap<String, bool> itemsMap =
      RxMap<String, bool>({for (var v in modulesList) v.title!: false});

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
      birthDateController.text = DateFormat.yMd().format(pickedDate);
    }
  }

  // Method to create a new participant and related modules

  Future<bool> createParticipantAndModules(
      int evaluatorId, List<String> selectedModules) async {
    String fullName = fullNameController.text;
    DateTime? birthDate = selectedDate.value;
    Sex? sex = selectedSex.value;
    EducationLevel? educationLevel = selectedEducationLevel.value;
    Handedness? handedness = selectedLaterality.value; // Ensure this is set

    List<String> nameParts = fullName.split(' ');
    String name = nameParts.first;
    String surname = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Include handedness in the constructor
    ParticipantEntity newParticipant = ParticipantEntity(
      name: name,
      surname: surname,
      birthDate: birthDate!,
      sex: sex!,
      educationLevel: educationLevel!,
      handedness: handedness!, // Corrected
    );


    var success = await participantService.createParticipantAndModules(
        evaluatorId, selectedModules, newParticipant);

    if (success.isNotEmpty) {
      final HomeController homeController = Get.find<HomeController>();
      homeController.addNewParticipant(newParticipant, success);
    }

    return true;
  }

  void printFormData() {
    print("Full Name: ${fullNameController.text}");
    print("Birth Date: ${birthDateController.text}");
    print("Sex: ${selectedSex.value}");
    print("Education Level: ${selectedEducationLevel.value}");
    print("Laterality: ${selectedLaterality.value}");
    print("Language: ${selectedLanguage.value}");
    // Add more prints as needed for other fields
  }

  @override
  void onClose() {
    // Dispose of controllers and any other resources
    fullNameController.dispose();
    birthDateController.dispose();
    // Dispose other resources if needed
    super.onClose();
  }
}
