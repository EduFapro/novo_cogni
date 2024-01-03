class TaskAudioFileEntity {
  int? fileID;
  int taskID;
  String filePath;

  TaskAudioFileEntity({
    this.fileID,
    required this.taskID,
    required this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'file_id': fileID,
      'task_id': taskID,
      'file_path': filePath,
    };
  }

  static TaskAudioFileEntity fromMap(Map<String, dynamic> map) {
    return TaskAudioFileEntity(
      fileID: map['file_id'] as int?,
      taskID: map['task_id'] as int,
      filePath: map['file_path'] as String,
    );
  }

  @override
  String toString() {
    return 'TaskAudioFileEntity(fileID: $fileID, taskID: $taskID, filePath: $filePath)';
  }
}
