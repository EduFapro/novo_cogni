import 'dart:convert';
import 'atividade_entity.dart';

class AvaliacaoEntity {
  final int? avaliacaoID;
  final int avaliadorID;
  final int participanteID;
  final List<AtividadeEntity> atividades;

  AvaliacaoEntity({
    this.avaliacaoID,
    required this.avaliadorID,
    required this.participanteID,
    required this.atividades,
  });

  Map<String, dynamic> toMap() {
    return {
      'avaliacao_id': avaliacaoID,  // Updated this line
      'avaliador_id': avaliadorID,
      'participante_id': participanteID,
      'atividades': jsonEncode(atividades.map((activity) => activity.toMap()).toList()),
    };
  }



  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map['avaliacao_id'] as int?,  // Updated this line
      avaliadorID: map['avaliador_id'] as int,
      participanteID: map['participante_id'] as int,
      atividades: (jsonDecode(map['atividades']) as List).map((activityMap) => AtividadeEntity.fromMap(activityMap)).toList(),
    );
  }


}
