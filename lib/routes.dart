import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:novo_cogni/modules/lista_modulos/lista_modulos_screen.dart';
import 'package:novo_cogni/modules/nova_senha/nova_senha_screen.dart';
import 'modules/avaliadores/avaliadores_binding.dart';
import 'modules/avaliadores/avaliadores_screen.dart';
import 'modules/cadastro_avaliador/cadastro_avaliador_binding.dart';
import 'modules/cadastro_avaliador/cadastro_avaliador_screen.dart';
import 'modules/cadastro_participante/cadastro_participante_binding.dart';
import 'modules/cadastro_participante/cadastro_participante_screen.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/login/login_binding.dart';
import 'modules/lista_modulos/lista_modulos_binding.dart';
import 'modules/nova_senha/nova_senha_binding.dart';
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
  static const novaSenha = '/new_password';
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
    binding: LoginBinding(),
  ),
  GetPage(
    name: AppRoutes.modulo,
    page: () => ListaModulosScreen(),
    binding: ListaModulosBinding(),
  ),
  GetPage(
    name: AppRoutes.tarefa,
    page: () => TarefaScreen(),
    binding: TarefaBinding(),
  ),
  GetPage(
    name: AppRoutes.novaSenha,
    page: () => NovaSenhaScreen(),
    binding: NovaSenhaBinding(),
  ),
];
