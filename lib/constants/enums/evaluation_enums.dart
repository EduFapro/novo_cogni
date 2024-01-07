enum EvaluationStatus { pending, in_progress, completed }

extension StatusDescription on EvaluationStatus {
  String get description {
    switch (this) {
      case EvaluationStatus.pending:
        return "Pending";
      case EvaluationStatus.in_progress:
        return "In Progress";
      case EvaluationStatus.completed:
        return "Completed";
      default:
        return "Unknown";
    }
  }
}
