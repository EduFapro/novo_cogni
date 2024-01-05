import '../../../constants/enums/module_enums.dart';
import '../../data/data_constants/module_instance_constants.dart';

class ModuleInstanceEntity {
  int? moduleInstanceID;
  int moduleID;
  int evaluationID;
  Status status;

  ModuleInstanceEntity({
    this.moduleInstanceID,
    required this.moduleID,
    required this.evaluationID,
    this.status = Status.to_start,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULE_INSTANCE: moduleInstanceID,
      ID_MODULE_FK: moduleID,
      ID_EVALUATION_FK: evaluationID,
      MODULE_INSTANCE_STATUS: status.description,
    };
  }

  static ModuleInstanceEntity fromMap(Map<String, dynamic> map) {
    return ModuleInstanceEntity(
      moduleInstanceID: map[ID_MODULE_INSTANCE] as int?,
      moduleID: map[ID_MODULE_FK],
      evaluationID: map[ID_EVALUATION_FK],
    );
  }

  @override
  String toString() {
    return 'ModuleInstanceEntity{moduleInstanceID: $moduleInstanceID, moduleID: $moduleID, evaluationID: $evaluationID, status: $status}';
  }
}
