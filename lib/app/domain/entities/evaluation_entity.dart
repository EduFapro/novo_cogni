import 'dart:convert';
import '../../../constants/enums/module_enums.dart';
import '../../data/data_constants/evaluation_constants.dart';

class EvaluationEntity {
  final int? evaluationID;
  final int evaluatorID;
  final int participantID;
  Status status;
  DateTime evaluationDate;

  EvaluationEntity({
    this.evaluationID,
    DateTime? evaluationDate,
    this.status = Status.to_start,
    required this.evaluatorID,
    required this.participantID,
  }) : evaluationDate = evaluationDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      ID_EVALUATION: evaluationID,
      EVALUATION_DATE: evaluationDate.toIso8601String(),
      ID_EVALUATOR_FK: evaluatorID,
      EVALUATION_STATUS: status.description,
      ID_PARTICIPANT_FK: participantID,
    };
  }

  static EvaluationEntity fromMap(Map<String, dynamic> map) {
    return EvaluationEntity(
      evaluationID: map[ID_EVALUATION] as int?,
      evaluatorID: map[ID_EVALUATOR_FK] as int,
      status: Status.values.firstWhere((e) => e.description == map[EVALUATION_STATUS], orElse: () => Status.to_start),
      evaluationDate: map[EVALUATION_DATE] != null ? DateTime.parse(map[EVALUATION_DATE] as String) : null,
      participantID: map[ID_PARTICIPANT_FK] as int,
    );
  }

  // Convert EvaluationEntity to JSON string
  String toJson() {
    final Map<String, dynamic> data = this.toMap();
    return jsonEncode(data);
  }

  // Convert JSON string to EvaluationEntity
  static EvaluationEntity fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return EvaluationEntity.fromMap(data);
  }

  @override
  String toString() {
    return 'EvaluationEntity(evaluationID: $evaluationID, evaluatorID: $evaluatorID, participantID: $participantID)';
  }

}
