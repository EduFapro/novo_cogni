import '../../utils/enums/atividade_enums.dart';

class AtividadeEntity {
  int? atividadeID;
  DateTime? date;
  int? score;
  int? evaluationID;
  Status status;

  AtividadeEntity({
    this.atividadeID,
    this.date,
    this.score,
    this.evaluationID,
    this.status = Status.a_iniciar,
  });

  Map<String, dynamic> toMap() {
    return {
      'atividade_id': atividadeID,
      'data_atividade': date?.toIso8601String(),
      'pontuacao': score,
      'status': status.description,
      'avaliacao_id': evaluationID,
    };
  }

  static AtividadeEntity fromMap(Map<String, dynamic> map) {
    return AtividadeEntity(
      atividadeID: map['activityID'] as int?,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      score: map['score'] as int?,
      evaluationID: map['evaluationID'] as int?,
      status: map['status'],
    );
  }
}
