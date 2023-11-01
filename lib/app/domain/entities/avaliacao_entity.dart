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
      'avaliacao_id': avaliacaoID,
      'avaliador_id': avaliadorID,
      'participante_id': participanteID,
      'modulos':
      jsonEncode(modulos.map((activity) => activity.toMap()).toList()),
    };
  }

  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map['avaliacao_id'] as int?,
      avaliadorID: map['avaliador_id'] as int,
      participanteID: map['participante_id'] as int,
      modulos: (jsonDecode(map['modulos']) as List)
          .map((activityMap) => ModuloEntity.fromMap(activityMap))
          .toList(),
    );
  }

  // Convert AvaliacaoEntity to JSON string
  String toJson() {
    final Map<String, dynamic> data = this.toMap();
    return jsonEncode(data);
  }

  // Convert JSON string to AvaliacaoEntity
  static AvaliacaoEntity fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return AvaliacaoEntity.fromMap(data);
  }
}
