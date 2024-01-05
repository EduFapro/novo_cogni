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
        return "Play";
      case TaskMode.record:
        return "Record";
      default:
        return "---";
    }
  }
}
