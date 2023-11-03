import 'dart:convert';
import '../../data/data_constants/avaliacao_constants.dart';
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
      ID_AVALIACAO: avaliacaoID,
      ID_AVALIADOR_FK: avaliadorID,
      ID_PARTICIPANTE_FK: participanteID,
      MODULOS: modulos != null
          ? jsonEncode(modulos.map((modulo) => modulo.toMap()).toList())
          : jsonEncode([]),
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
