import '../../utils/enums/modulo_enums.dart';

class ModuloEntity {
  int? moduloID;
  DateTime? date;
  int? score;
  int? evaluationID;
  Status status;

  ModuloEntity({
    this.moduloID,
    this.date,
    this.score,
    this.evaluationID,
    this.status = Status.a_iniciar,
  });

  Map<String, dynamic> toMap() {
    return {
      'modulo_id': moduloID,
      'data_modulo': date?.toIso8601String(),
      'pontuacao': score,
      'status': status.description,
      'avaliacao_id': evaluationID,
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map['activityID'] as int?,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      score: map['score'] as int?,
      evaluationID: map['evaluationID'] as int?,
      status: map['status'],
    );
  }
}
