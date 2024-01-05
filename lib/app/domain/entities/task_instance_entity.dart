import 'package:novo_cogni/app/domain/entities/task_entity.dart';

class TaskInstanceEntity {
  int? taskInstanceID;
  int taskID;
  int moduleInstanceID;
  String status;
  TaskEntity? task;

  TaskInstanceEntity({
    this.taskInstanceID,
    required this.taskID,
    required this.moduleInstanceID,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'task_inst_id': taskInstanceID,
      'task_id': taskID,
      'module_inst_id': moduleInstanceID,
      'status': status,
    };
  }

  static TaskInstanceEntity fromMap(Map<String, dynamic> map) {
    return TaskInstanceEntity(
      taskInstanceID: map['task_inst_id'] as int?,
      taskID: map['task_id'] as int,
      moduleInstanceID: map['module_inst_id'] as int,
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return 'TaskInstanceEntity(taskInstanceID: $taskInstanceID, taskID: $taskID, moduleInstanceID: $moduleInstanceID, status: $status)';
  }
}
