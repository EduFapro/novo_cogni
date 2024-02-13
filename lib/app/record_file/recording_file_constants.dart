import 'package:novo_cogni/app/task_instance/task_instance_constants.dart';

import '../database_constants.dart';

const ID_RECORDING = "recording_id";
const ID_TASK_INSTANCE_FK = ID_TASK_INSTANCE;
const FILE_PATH = "file_path";

const SCRIPT_CREATE_TABLE_RECORDINGS = '''
  CREATE TABLE $TABLE_RECORDINGS
  (
    $ID_RECORDING INTEGER PRIMARY KEY AUTOINCREMENT,
    $ID_TASK_INSTANCE_FK INTEGER UNIQUE NOT NULL,
    $FILE_PATH TEXT NOT NULL,
    FOREIGN KEY ($ID_TASK_INSTANCE_FK) REFERENCES $TABLE_TASKS($ID_TASK_INSTANCE_FK)
  )
''';
