import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:novo_cogni/modules/lista_modulos/module_controller.dart';
import 'package:novo_cogni/modules/lista_modulos/modules_list_screen.dart';

import 'modules/evaluator_registration/evaluator_registration_binding.dart';
import 'modules/evaluator_registration/evaluator_registration_screen.dart';
import 'modules/evaluators/evaluators_binding.dart';
import 'modules/evaluators/evaluators_screen.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_screen.dart';
import 'modules/lista_modulos/modules_list_binding.dart';
import 'modules/login/login_screen.dart';
import 'modules/login/login_binding.dart';
import 'modules/new_password/new_password_binding.dart';
import 'modules/new_password/new_password_screen.dart';
import 'modules/participant_registration/participant_registration_binding.dart';
import 'modules/task/task_binding.dart';
import 'modules/task/task_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const evaluatorRegistration = '/evaluatorRegistration';
  static const evaluators = '/evaluators';
  static const participantRegistration = '/participantRegistration';
  static const module = '/module';
  static const task = '/task';
  static const newPassword = '/new_password';
}

final routes = [
  GetPage(
    name: AppRoutes.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.evaluators,
    page: () => EvaluatorsScreen(),
    binding: EvaluatorsBinding(),
  ),
  GetPage(
    name: AppRoutes.evaluatorRegistration,
    page: () => EvaluatorRegistrationScreen(),
    binding: EvaluatorRegistrationBinding(),
  ),
  GetPage(
    name: AppRoutes.participantRegistration,
    page: () => ParticipantRegistrationScreen(),
    binding: ParticipantRegistrationBinding(),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: AppRoutes.module,
    page: () => ModulesListScreen(),
    binding: ModulesListBinding(),
  ),
  GetPage(
    name: AppRoutes.task,
    page: () => TaskScreen(),
    binding: TaskBinding(),
  ),
  GetPage(
    name: AppRoutes.newPassword,
    page: () => NewPasswordScreen(),
    binding: NewPasswordBinding(),
  ),
];
