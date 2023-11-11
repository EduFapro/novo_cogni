import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:novo_cogni/modules/modulo_atividades/modulo_screen.dart';
import 'modules/avaliadores/avaliadores_binding.dart';
import 'modules/avaliadores/avaliadores_screen.dart';
import 'modules/cadastro_avaliador/cadastro_avaliador_binding.dart';
import 'modules/cadastro_avaliador/cadastro_avaliador_screen.dart';
import 'modules/cadastro_participante/cadastro_participante_binding.dart';
import 'modules/cadastro_participante/cadastro_participante_screen.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/login/login_screen_binding.dart';
import 'modules/modulo_atividades/modulo_binding.dart';
import 'modules/tarefa/tarefa_binding.dart';
import 'modules/tarefa/tarefa_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const cadastroAvaliador = '/cadastroAvaliador';
  static const avaliadores = '/avaliadores';
  static const cadastroParticipante = '/cadastroParticipante';
  static const modulo = '/modulo';
  static const tarefa = '/tarefa';
}

final routes = [
  GetPage(
    name: AppRoutes.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.avaliadores,
    page: () => AvaliadoresScreen(),
    binding: AvaliadoresBinding(),
  ),
  GetPage(
    name: AppRoutes.cadastroAvaliador,
    page: () => CadastroAvaliadorScreen(),
    binding: CadastroAvaliadorBinding(),
  ),
  GetPage(
    name: AppRoutes.cadastroParticipante,
    page: () => CadastroParticipanteScreen(),
    binding: CadastroParticipanteBinding(),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => LoginScreen(),
    binding: LoginScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.modulo,
    page: () => ModuloScreen(),
    binding: ModuloBinding(),
  ),
  GetPage(
    name: AppRoutes.tarefa,
    page: () => TarefaScreen(),
    binding: TarefaBinding(),
  ),

];
