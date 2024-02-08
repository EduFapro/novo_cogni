import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/enums/language_enums.dart';
import '../participant_registration/participant_registration_controller.dart';

class EdLanguageFormDropdown extends GetView<ParticipantRegistrationController> {
  const EdLanguageFormDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<Language>(
      hint: Text(controller.selectedLanguage.value?.translationKey ?? Language.portuguese.translationKey),
      onChanged: (Language? value) {

          controller.selectedLanguage.value = value;

      },
      value: controller.selectedLanguage.value,
      items: [
        DropdownMenuItem<Language>(
          value: Language.portuguese,
          child: Text(Language.portuguese.translationKey),
        ),
        DropdownMenuItem<Language>(
          value: Language.spanish,
          child: Text(Language.spanish.translationKey),
        ),
      ],
    ));
  }
}

