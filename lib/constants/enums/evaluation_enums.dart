import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum EvaluationStatus { pending, in_progress, completed }

extension StatusDescription on EvaluationStatus {
  String get description {
    switch (this) {
      case EvaluationStatus.pending:
        return 'pending_evaluation'.tr;
      case EvaluationStatus.in_progress:
        return 'in_progress_evaluation'.tr;
      case EvaluationStatus.completed:
        return 'completed_evaluation'.tr;
      default:
        return 'unknown';
    }
  }
}


// Map that associates enum cases with custom integer values.
const Map<EvaluationStatus, int> _statusValues = {
  EvaluationStatus.pending: 1,
  EvaluationStatus.in_progress: 2,
  EvaluationStatus.completed: 3,
};


// Extension to get custom integer value from enum case.
extension EvaluationStatusExtension on EvaluationStatus {
  int get numericValue => _statusValues[this] ?? 0;

  static EvaluationStatus fromValue(int numericValue) {
    return _statusValues.entries
        .firstWhere((element) => element.value == numericValue,
        orElse: () => MapEntry(EvaluationStatus.pending, 0))
        .key;
  }
}