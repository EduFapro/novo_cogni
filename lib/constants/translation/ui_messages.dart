import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/pt_br_translations.dart';

import 'en_us_translations.dart';
import 'es_es_translations.dart';

class UiMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUsTranslations,
    'pt_BR': ptBrTranslations,
    'es_ES': esEsTranslations
  };

  static String get cpfAlreadyInUse => 'cpf_already_in_use'.tr;

}
