import 'package:novo_cogni/app/data/data_constants/task_constants.dart';

import 'audio_file_constants.dart';
import 'database_constants.dart';
import 'module_instance_constants.dart';

const ID_TASK_INSTANCE = "task_inst_id";
const ID_TASK_FK = "task_id";
const ID_MODULE_INSTANCE_FK = "module_inst_id";
const ID_FILE_FK = "file_id";
const TASK_INSTANCE_STATUS = "status";

const SCRIPT_CREATE_TABLE_TASK_INSTANCES = '''
  CREATE TABLE $TABLE_TASK_INSTANCES
  (
    $ID_TASK_INSTANCE INTEGER PRIMARY KEY AUTOINCREMENT,
    $ID_TASK_FK INTEGER NOT NULL,
    $ID_MODULE_INSTANCE_FK INTEGER NOT NULL,
    $ID_FILE_FK INTEGER NOT NULL,
    $TASK_INSTANCE_STATUS TEXT NOT NULL,
    FOREIGN KEY ($ID_TASK_FK) REFERENCES $TABLE_TASKS($ID_TASK),
    FOREIGN KEY ($ID_MODULE_INSTANCE_FK) REFERENCES $TABLE_MODULE_INSTANCES($ID_MODULE_INSTANCE),
    FOREIGN KEY ($ID_FILE_FK) REFERENCES $TABLE_FILES($ID_FILE)
  )
''';
