import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/global/language_controller.dart';
import '../../constants/enums/language_enums.dart';

class EdLanguageDropdown extends GetView<LanguageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<Language>(
      hint: Text(Language.portuguese.translationKey),
      value: controller.currentLanguage.value,
      onChanged: (Language? newValue) {
        if (newValue != null) {
          controller.changeLanguage(newValue);
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

