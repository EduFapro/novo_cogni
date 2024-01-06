import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/global/language_controller.dart';

class EdLanguageDropdown extends GetView<LanguageController> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      hint: Text('Select Language'),
      onChanged: (Locale? newValue) {
        if (newValue != null) {
          controller.changeLanguage(newValue);
        }
      },
      items: controller.locales.map<DropdownMenuItem<Locale>>((localeInfo) {
        return DropdownMenuItem<Locale>(
          value: localeInfo.locale,
          child: Text(localeInfo.name),
        );
      }).toList(),
    );
  }
}

