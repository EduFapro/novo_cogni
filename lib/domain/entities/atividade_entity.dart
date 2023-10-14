class AtividadeEntity {
  int? atividadeID;
  final DateTime date;
  final int score;
  final int evaluationID;

  AtividadeEntity({
    this.atividadeID,
    required this.date,
    required this.score,
    required this.evaluationID,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': atividadeID,
      'date': date.toIso8601String(),
      'score': score,
      'evaluationID': evaluationID,
    };
  }

  static AtividadeEntity fromMap(Map<String, dynamic> map) {
    return AtividadeEntity(
      atividadeID: map['activityID'] as int?,
      date: DateTime.parse(map['date'] as String),
      score: map['score'] as int,
      evaluationID: map['evaluationID'] as int,
    );
  }
}
