enum TaskStatus { toBegin, done }
enum TaskMode {
  play,
  record,
}

extension StatusDescription on TaskStatus {
  String get description {
    switch (this) {
      case TaskStatus.toBegin:
        return "Begin";
      case TaskStatus.done:
        return "Done";
      default:
        return "---";
    }
  }
}

extension ModeDescription on TaskMode {
  String get description {
    switch (this) {
      case TaskMode.play:
        return "Play";  // Changed to "Play" to reflect the action
      case TaskMode.record:
        return "Record"; // Changed to "Record" to reflect the action
      default:
        return "---";
    }
  }
}
