import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final List<LocaleInfo> locales = [
    LocaleInfo(name: 'English', locale: Locale('en', 'US')),
    LocaleInfo(name: 'Português', locale: Locale('pt', 'BR')),
    LocaleInfo(name: 'Español', locale: Locale('es', 'ES')),
  ];

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
  }
}

class LocaleInfo {
  final String name;
  final Locale locale;

  LocaleInfo({required this.name, required this.locale});
}