import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/task_entity.dart';
import '../../../constants/enums/task_enums.dart';
import '../../data/data_constants/task_instance_constants.dart';
import '../repositories/task_repository.dart';

class TaskInstanceEntity {
  int? taskInstanceID;
  int taskID;
  int moduleInstanceID;
  TaskStatus status;
  TaskEntity? _task;
  int? completingTime;

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
    return TaskInstanceEntity(
      taskInstanceID: map[ID_TASK_INSTANCE] as int?,
      taskID: map[ID_TASK_FK] as int,
      moduleInstanceID: map[ID_MODULE_INSTANCE_FK] as int,
      status: TaskStatusExtension.fromNumericValue(map[TASK_INSTANCE_STATUS] as int),
      completingTime: map[TASK_COMPLETING_TIME] as int?,
    );
  }


  Future<TaskEntity?> get task async {
    if (_task == null) {
      var fetchedTask = await Get.find<TaskRepository>().getTask(taskID);
      if (fetchedTask != null) {
        var taskMapCopy = Map<String, dynamic>.from(fetchedTask.toMap());
        _task = TaskEntity.fromMap(taskMapCopy);
      }
    }
    return _task;
  }



  void updateDuration(Duration duration) {
    completingTime = duration.inSeconds;
  }
  void completeTask(Duration duration) {
    status = TaskStatus.done;
    completingTime = duration.inSeconds;
  }
  @override
  String toString() {
    return 'TaskInstanceEntity(taskInstanceID: $taskInstanceID, taskID: $taskID, moduleInstanceID: $moduleInstanceID, status: $status, duration: $completingTime seconds)';
  }
}
