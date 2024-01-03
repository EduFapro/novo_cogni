import 'package:novo_cogni/app/domain/entities/task_entity.dart';

import '../../data/data_constants/module_constants.dart';

class ModuleEntity {
  int? moduleID;
  String? title;
  List<TaskEntity> tasks;

  ModuleEntity({
    this.moduleID,
    this.title,
    this.tasks = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULE: moduleID,
      TITLE: title,
    };
  }

  static ModuleEntity fromMap(Map<String, dynamic> map) {
    return ModuleEntity(
      moduleID: map[ID_MODULE] as int?,
      title: map[TITLE] as String?,
    );
  }



}
