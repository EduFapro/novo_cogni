import 'dart:convert';
import 'modulo_entity.dart';

class AvaliacaoEntity {
  final int? avaliacaoID;
  final int avaliadorID;
  final int participanteID;
  final List<ModuloEntity> modulos;

  AvaliacaoEntity({
    this.avaliacaoID,
    required this.avaliadorID,
    required this.participanteID,
    required this.modulos,
  });

  Map<String, dynamic> toMap() {
    return {
      'avaliacao_id': avaliacaoID,  // Updated this line
      'avaliador_id': avaliadorID,
      'participante_id': participanteID,
      'modulos': jsonEncode(modulos.map((activity) => activity.toMap()).toList()),
    };
  }



  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map['avaliacao_id'] as int?,  // Updated this line
      avaliadorID: map['avaliador_id'] as int,
      participanteID: map['participante_id'] as int,
      modulos: (jsonDecode(map['modulos']) as List).map((activityMap) => ModuloEntity.fromMap(activityMap)).toList(),
    );
  }


}
