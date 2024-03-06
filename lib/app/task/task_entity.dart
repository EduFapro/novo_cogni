import 'package:novo_cogni/app/task/task_constants.dart';
import '../../../constants/enums/task_enums.dart';

class TaskEntity {
  int? taskID;
  int moduleID;
  String title;
  TaskMode taskMode;
  int position;
  String? image_path;
  int timeForCompletion;

  TaskEntity({
    this.taskID,
    required this.moduleID,
    required this.title,
    required this.taskMode,
    required this.position,
    this.image_path,
    this.timeForCompletion = 30,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_TASK: taskID,
      TITLE: title,
      MODULE_ID: moduleID,
      MODE: taskMode.numericValue,
      POSITION: position,
      IMAGE_PATH: image_path,
      TIME_FOR_COMPLETION: timeForCompletion,
    };
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {

    final mode = TaskMode.fromNumericValue(map[MODE] as int);
    return TaskEntity(
      taskID: map[ID_TASK] as int?,
      title: map[TITLE] as String,
      moduleID: map[MODULE_ID] as int,
      taskMode: mode,
      position: map[POSITION] as int,
      image_path: map[IMAGE_PATH] as String?,
      timeForCompletion: map[TIME_FOR_COMPLETION],
    );
  }



  @override
  String toString() {
    return 'TaskEntity{'
        'task_id: $taskID, '
        'title: "$title", '
        'taskMode: ${taskMode.description}, '
        'position: $position, '
        'image_path: "$image_path,'
        'imeForCompletion: $timeForCompletion'
        '}';
  }
}
