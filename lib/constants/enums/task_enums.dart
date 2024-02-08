import 'package:get/get.dart';

enum TaskStatus { pending, done }

extension TaskStatusExtension on TaskStatus {
  int get numericValue {
    switch (this) {
      case TaskStatus.pending:
        return 0;
      case TaskStatus.done:
        return 1;
      default:
        return 0;
    }
  }

  String get description {
    switch (this) {
      case TaskStatus.pending:
        return 'pending_task'.tr;
      case TaskStatus.done:
        return 'done_task'.tr;
      default:
        return 'unknown'.tr;
    }
  }

  static TaskStatus fromNumericValue(int value) {
    if (value == 1) return TaskStatus.done;
    return TaskStatus.pending;
  }
}

enum TaskMode { play, record }

extension TaskModeExtension on TaskMode {
  int get numericValue {
    switch (this) {
      case TaskMode.play:
        return 0;
      case TaskMode.record:
        return 1;
      default:
        return 0;
    }
  }

  String get description {
    switch (this) {
      case TaskMode.play:
        return 'play_mode'.tr;
      case TaskMode.record:
        return 'record_mode'.tr;
      default:
        return 'unknown'.tr;
    }
  }

  static TaskMode fromNumericValue(int value) {
    if (value == 1) return TaskMode.record;
    return TaskMode.play; // Default to play
  }
}
