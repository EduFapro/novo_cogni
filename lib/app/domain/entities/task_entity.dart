import 'package:novo_cogni/app/data/data_constants/task_constants.dart';

import '../../../constants/enums/task_enums.dart';

class TaskEntity {
  int? taskID;
  int moduleID;
  String title;
  TaskMode taskMode;
  int position;
  String? image_path;

  TaskEntity(
      {this.taskID,
      required this.moduleID,
      required this.title,
      required this.taskMode,
      required this.position,
      this.image_path});

  Map<String, dynamic> toMap() {
    return {
      ID_TASK: taskID,
      TITLE: title,
      MODULE_ID: moduleID,
      MODE: taskMode.description,
      POSITION: position,
      IMAGE_PATH: image_path
    };
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {
    return TaskEntity(
        taskID: map[ID_TASK] as int?,
        title: map[TITLE] as String,
        moduleID: map[MODULE_ID],
        taskMode: map[MODE] == TaskMode.record.description ? TaskMode.record : TaskMode.play,
        position: map[POSITION],
        image_path: map[IMAGE_PATH]);
  }

  @override
  String toString() {
    return 'TaskEntity{'
        'task_id: $taskID, '
        'name: "$title", '
        '}';
  }
}
