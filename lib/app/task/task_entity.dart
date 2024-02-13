import 'package:novo_cogni/app/task/task_constants.dart';
import '../../../constants/enums/task_enums.dart';

class TaskEntity {
  int? taskID;
  int moduleID;
  String title;
  TaskMode taskMode;
  int position;
  String? image_path;

  TaskEntity({
    this.taskID,
    required this.moduleID,
    required this.title,
    required this.taskMode,
    required this.position,
    this.image_path,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_TASK: taskID,
      TITLE: title,
      MODULE_ID: moduleID,
      MODE: taskMode.numericValue, // Store as numeric value
      POSITION: position,
      IMAGE_PATH: image_path,
    };
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {
    // No need for additional checks here if the data is guaranteed to be int
    final mode = TaskMode.fromNumericValue(map[MODE] as int);
    return TaskEntity(
      taskID: map[ID_TASK] as int?,
      title: map[TITLE] as String,
      moduleID: map[MODULE_ID] as int,
      taskMode: mode,
      position: map[POSITION] as int,
      image_path: map[IMAGE_PATH] as String?,
    );
  }



  @override
  String toString() {
    return 'TaskEntity{'
        'task_id: $taskID, '
        'title: "$title", '
        'taskMode: ${taskMode.description}, '
        'position: $position, '
        'image_path: "$image_path"'
        '}';
  }
}
