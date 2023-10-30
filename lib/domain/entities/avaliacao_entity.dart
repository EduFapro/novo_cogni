import 'dart:convert';
import 'modulo_entity.dart';

class AvaliacaoEntity {
  final int? avaliacaoID;
  final int avaliadorID;
  final int participanteID;


  AvaliacaoEntity({
    this.avaliacaoID,
    required this.avaliadorID,
    required this.participanteID,
  });

  Map<String, dynamic> toMap() {
    return {
      'avaliacao_id': avaliacaoID,  // Updated this line
      'avaliador_id': avaliadorID,
      'participante_id': participanteID,
    };
  }



  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map['avaliacao_id'] as int?,  // Updated this line
      avaliadorID: map['avaliador_id'] as int,
      participanteID: map['participante_id'] as int,
    );
  }


}
