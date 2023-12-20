import 'dart:convert';
import '../../data/data_constants/evaluation_constants.dart';
import '../../enums/modulo_enums.dart';

class AvaliacaoEntity {
  final int? avaliacaoID;
  final int avaliadorID;
  final int participanteID;
  Status status;
  DateTime? dataAvaliacao;

  AvaliacaoEntity({
    this.avaliacaoID,
    this.dataAvaliacao,
    this.status = Status.a_iniciar,
    required this.avaliadorID,
    required this.participanteID,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_AVALIACAO: avaliacaoID,
      DATA_AVALIACAO: dataAvaliacao?.toIso8601String(),
      ID_AVALIADOR_FK: avaliadorID,
      STATUS: status.description,
      ID_PARTICIPANTE_FK: participanteID,
    };
  }


  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map[ID_AVALIACAO] as int?,
      avaliadorID: map[ID_AVALIADOR_FK] as int,
      status: Status.values.firstWhere((e) => e.description == map[STATUS], orElse: () => Status.a_iniciar),
      dataAvaliacao: map[DATA_AVALIACAO] != null ? DateTime.parse(map[DATA_AVALIACAO] as String) : null,
      participanteID: map[ID_PARTICIPANTE_FK] as int,
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

  @override
  String toString() {
    return 'AvaliacaoEntity(avaliacaoID: $avaliacaoID, avaliadorID: $avaliadorID, participanteID: $participanteID)';
  }

}
