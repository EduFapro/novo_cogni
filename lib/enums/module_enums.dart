enum Status { to_start, in_progress, completed }

extension StatusDescription on Status {
  String get description {
    switch (this) {
      case Status.to_start:
        return "To Start";
      case Status.in_progress:
        return "In Progress";
      case Status.completed:
        return "Completed";
      default:
        return "Unknown";
    }
  }
}
