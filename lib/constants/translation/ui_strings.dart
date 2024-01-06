import 'package:get/get.dart';

class UiStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello',
      'new_participant': 'New Participant',
      'password': 'Password',
      'forgot_your_password': 'Forgot your password?',
      'login': 'Login',
      'email': 'Email',
      'home': 'Home',
      'evaluators': 'Evaluators',
      'total_projects': 'Total Projects',
      'in_progress': 'In Progress',
      'completed': 'Completed',
      'evaluation_history': 'Evaluation History',
      'name': 'Name',
      'status': 'Status',
      'evaluator': 'Evaluator',
      'date': 'Date',
    },
    'pt_BR': {
      'hello': 'Olá',
      'new_participant': 'Novo Participante',
      'password': 'Senha',
      'forgot_your_password': 'Esqueceu sua senha?',
      'login': 'Entrar',
      'email': 'E-mail',
      'home': 'Início',
      'evaluators': 'Avaliadores',
      'total_projects': 'Total de Projetos',
      'in_progress': 'Em Andamento',
      'completed': 'Concluídos',
      'evaluation_history': 'Histórico de Avaliações',
      'name': 'Nome',
      'status': 'Status',
      'evaluator': 'Avaliador',
      'date': 'Data',
    },
    'es_ES': {
      'hello': 'Hola',
      'new_participant': 'Nuevo Participante',
      'password': 'Contraseña',
      'forgot_your_password': '¿Olvidó su contraseña?',
      'login': 'Iniciar sesión',
      'email': 'Correo electrónico',
      'home': 'Inicio',
      'evaluators': 'Evaluadores',
      'total_projects': 'Proyectos Totales',
      'in_progress': 'En Progreso',
      'completed': 'Completados',
      'evaluation_history': 'Historial de Evaluaciones',
      'name': 'Nombre',
      'status': 'Estado',
      'evaluator': 'Evaluador',
      'date': 'Fecha',
    }
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
}
