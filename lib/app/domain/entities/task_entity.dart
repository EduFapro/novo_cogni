import 'package:novo_cogni/app/data/data_constants/task_constants.dart';


class TaskEntity {
  int? taskID;
  int? moduleID;
  String name;

  TaskEntity({
    this.taskID,
    required this.name,
    this.moduleID,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_TASK: taskID,
      NAME: name,
      MODULE_ID: moduleID,
    };
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      taskID: map[ID_TASK] as int?,
      name: map[NAME] as String,
      moduleID: map[MODULE_ID] as int?,
    );
  }

  @override
  String toString() {
    return 'TaskEntity{'
        'task_id: $taskID, '
        'name: "$name", '
        '}';
  }
}
