import 'package:get/get.dart';
import '../../../constants/enums/task_enums.dart';
import '../task/task_entity.dart';
import 'task_instance_constants.dart';
import '../task/task_repository.dart';

class TaskInstanceEntity {
  int? taskInstanceID;
  int taskID;
  int moduleInstanceID;
  TaskStatus status;
  TaskEntity? _task;
  String? completingTime;

  TaskInstanceEntity({
    this.taskInstanceID,
    required this.taskID,
    required this.moduleInstanceID,
    this.status = TaskStatus.pending,
    this.completingTime,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_TASK_INSTANCE: taskInstanceID,
      ID_TASK_FK: taskID,
      ID_MODULE_INSTANCE_FK: moduleInstanceID,
      TASK_INSTANCE_STATUS: status.numericValue,
      TASK_COMPLETING_TIME: completingTime,
    };
  }

  static TaskInstanceEntity fromMap(Map<String, dynamic> map) {
    final status =
        TaskStatus.fromNumericValue(map[TASK_INSTANCE_STATUS] as int);
    return TaskInstanceEntity(
      taskInstanceID: map[ID_TASK_INSTANCE] as int?,
      taskID: map[ID_TASK_FK] as int,
      moduleInstanceID: map[ID_MODULE_INSTANCE_FK] as int,
      status: status,
      completingTime: map[TASK_COMPLETING_TIME],
    );
  }

  Future<TaskEntity?> get task async {
    if (_task == null) {
      _task = await Get.find<TaskRepository>().getTask(taskID);
    }
    return _task;
  }

  Map<String, dynamic> toJson() {
    return {
      'taskInstanceID': taskInstanceID,
      'taskID': taskID,
      'moduleInstanceID': moduleInstanceID,
      'status': status.numericValue,
      'completingTime': completingTime,
    };
  }

  Future<Map<String, dynamic>> detailedJson() async {
    final tarefa = await task;
    return {
      'Tarefa': tarefa!.title,
      'Status': status.numericValue == 1 ? "Concluído" : "A Realizar",
      'Tempo da Gravação': completingTime,
    };
  }

  void updateDuration(String duration) {
    completingTime = duration;
  }

  void completeTask(String duration) {
    status = TaskStatus.done;
    completingTime = duration;
  }

  @override
  String toString() {
    return 'TaskInstanceEntity(taskInstanceID: $taskInstanceID, taskID: $taskID, moduleInstanceID: $moduleInstanceID, status: $status, duration: $completingTime seconds)';
  }
}
