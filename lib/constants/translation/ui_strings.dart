import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/pt_br_translations.dart';

import 'en_us_translations.dart';
import 'es_es_translations.dart';

class UiStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUsTranslations,
        'pt_BR': ptBrTranslations,
        'es_ES': esEsTranslations
      };

  // Static getters for translation keys
  static String get hello => 'hello'.tr;

  static String get newParticipant => 'new_participant'.tr;

  static String get password => 'password'.tr;

  static String get forgotYourPassword => 'forgot_your_password'.tr;

  static String get login => 'login'.tr;

  static String get email => 'email'.tr;

  static String get home => 'home'.tr;

  static String get evaluators => 'evaluators'.tr;

  static String get totalProjects => 'total_projects'.tr;

  static String get inProgress => 'in_progress'.tr;

  static String get completed => 'completed'.tr;

  static String get evaluationHistory => 'evaluation_history'.tr;

  static String get name => 'name'.tr;

  static String get status => 'status'.tr;

  static String get evaluator => 'evaluator'.tr;

  static String get date => 'date'.tr;

  static String get participantRegistration => 'participant_registration'.tr;

  static String get identificationData => 'identification_data'.tr;

  static String get fullName => 'full_name'.tr;

  static String get dateOfBirth => 'date_of_birth'.tr;

  static String get sex => 'sex'.tr;

  static String get educationLevel => 'education_level'.tr;

  static String get laterality => 'laterality'.tr;

  static String get modules => 'modules'.tr;

  static String get language => 'language'.tr;

  static String get selectedModules => 'selected_modules'.tr;

  static String get register => 'register'.tr;

  static String get cancel => 'cancel'.tr;

  static String get evaluatorsList => 'evaluators_list'.tr;

  static String get newEvaluator => 'new_evaluator'.tr;

  static String get evaluatorRegistration => 'evaluator_registration'.tr;

  static String get specialty => 'specialty'.tr;

  static String get cpfNif => 'cpf_nif'.tr;

  static String get evaluation => 'evaluation'.tr;

  static String get listOfActivities => 'list_of_activities'.tr;
}
