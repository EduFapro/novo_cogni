import 'package:novo_cogni/app/evaluation/evaluation_entity.dart';
import 'package:novo_cogni/app/module_instance/module_instance_entity.dart';

import '../app/task_instance/task_instance_entity.dart';

typedef TaskInstanceList = List<TaskInstanceEntity>;
typedef ModuleInstanceMap = Map<ModuleInstanceEntity, TaskInstanceList>;
typedef EvaluationMap = Map<EvaluationEntity, ModuleInstanceMap>;
