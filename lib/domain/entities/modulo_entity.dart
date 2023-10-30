import 'dart:convert';

import '../../utils/enums/modulo_enums.dart';

class ModuloEntity {
  int? moduloID;
  DateTime? date;
  int? score;
  int? evaluationID;
  Status status;
  List<String> modulos;

  ModuloEntity({
    this.moduloID,
    this.date,
    this.score,
    this.evaluationID,
    this.status = Status.a_iniciar,
    required this.modulos,
  });

  Map<String, dynamic> toMap() {
    return {
      'modulo_id': moduloID,
      'data_modulo': date?.toIso8601String(),
      'pontuacao': score,
      'status': status.description,
      'avaliacao_id': evaluationID,
      'modulos': jsonEncode(modulos),
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map['activityID'] as int?,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      score: map['score'] as int?,
      evaluationID: map['evaluationID'] as int?,
      status: map['status'],
      modulos: (jsonDecode(map['modulos']) as List).map((activity) => activity.toString()).toList(),  // Convert each item in the list to a String
    );
  }
}
