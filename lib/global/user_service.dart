import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import 'package:novo_cogni/app/domain/repositories/avaliacao_modulo_repository.dart';
import 'package:novo_cogni/app/domain/repositories/avaliacao_repository.dart';
import 'package:novo_cogni/app/domain/repositories/avaliador_repository.dart';
import '../app/domain/entities/avaliacao_entity.dart';
import '../app/domain/entities/avaliador_entity.dart';
import '../app/domain/repositories/participante_repository.dart';

class UserService {

  var userRepo = Get.find<AvaliadorRepository>();
  var avaliacaoRepo = Get.find<AvaliacaoRepository>();
  var avaliacaoModuloRepo = Get.find<AvaliacaoModuloRepository>();
  var participanteRepo = Get.find<ParticipanteRepository>();

  Future<AvaliadorEntity?> getUser(int id) async {
    return await userRepo.getAvaliador(id);
  }
  
  Future<List<AvaliacaoEntity>> getAvaliacoesByUser(AvaliadorEntity user) async {
    return await avaliacaoRepo.getAvaliacoesByAvaliadorID(user.avaliadorID!);
  }

  Future<List<ModuloEntity>> getModulosByAvaliacao(AvaliacaoEntity avaliacao) async {
    return await avaliacaoModuloRepo.getModulosByAvaliacaoId(avaliacao.avaliacaoID!);
  }


}