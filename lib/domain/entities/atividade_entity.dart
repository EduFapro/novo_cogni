class AtividadeEntity {
  int? atividadeID;
  DateTime? date;
  int? score;
  int? evaluationID;

  AtividadeEntity({
    this.atividadeID,
    this.date,
    this.score,
    this.evaluationID,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': atividadeID,
      'date': date?.toIso8601String(),
      'score': score,
      'evaluationID': evaluationID,
    };
  }

  static AtividadeEntity fromMap(Map<String, dynamic> map) {
    return AtividadeEntity(
      atividadeID: map['activityID'] as int?,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      score: map['score'] as int?,
      evaluationID: map['evaluationID'] as int?,
    );
  }
}
