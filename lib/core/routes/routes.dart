import 'package:get/get.dart';
import '../../presentation/views/avaliadores_screen/avaliadores_screen.dart';
import '../../presentation/views/cadastro_avaliador_screen/cadastro_avaliador_screen.dart';
import '../../presentation/views/cadastro_participante_screen/cadastro_participante_screen.dart';
import '../../presentation/views/home_screen/home_screen.dart';
import '../../presentation/views/login_screen/login_screen.dart';
import '../bindings/avaliadores_binding.dart';
import '../bindings/cadastro_avaliador_binding.dart';
import '../bindings/cadastro_participante_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/login_screen_binding.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const cadastroAvaliador = '/cadastroAvaliador';
  static const avaliadores = '/avaliadores';
  static const cadastroParticipante = '/cadastroParticipante';
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

];
