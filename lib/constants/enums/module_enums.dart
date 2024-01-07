enum ModuleStatus { pending, in_progress, completed }

extension ModuleStatusDescription on ModuleStatus {
  String get description {
    switch (this) {
      case ModuleStatus.pending:
        return "Pending";
      case ModuleStatus.in_progress:
        return "In Progress";
      case ModuleStatus.completed:
        return "Completed";
      default:
        return "Unknown";
    }
  }
}
