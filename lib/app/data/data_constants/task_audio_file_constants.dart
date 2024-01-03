import 'database_constants.dart';

const ID_FILE = "file_id";
const ID_TASK_FK = "task_id";
const FILE_PATH = "file_path";

const SCRIPT_CREATE_TABLE_FILES = '''
  CREATE TABLE $TABLE_FILES
  (
    $ID_FILE INTEGER PRIMARY KEY AUTOINCREMENT,
    $ID_TASK_FK INTEGER UNIQUE NOT NULL,
    $FILE_PATH TEXT NOT NULL,
    FOREIGN KEY ($ID_TASK_FK) REFERENCES $TABLE_TASKS($ID_TASK_FK)
  )
''';
