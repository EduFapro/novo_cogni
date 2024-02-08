import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/enums/language_enums.dart';
import '../participant_registration/participant_registration_controller.dart';

class EdLanguageFormDropdown extends GetView<ParticipantRegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<Language>(
      value: controller.selectedLanguage.value,
      onChanged: (Language? newValue) {
        if (newValue != null) {
          controller.selectedLanguage.value = newValue;
        }
      },
      items: Language.values.map<DropdownMenuItem<Language>>((language) {
        return DropdownMenuItem<Language>(
          value: language,
          child: Text(language.translationKey),
        );
      }).toList(),
    ));
  }
}



