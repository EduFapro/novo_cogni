
import 'database_constants.dart';
import 'module_constants.dart';

const ID_TASK = "task_id";
const NAME = "name";
const MODULE_ID = "module_id";

const SCRIPT_CREATE_TABLE_TASKS = '''
  CREATE TABLE $TABLE_TASKS
  (
    $ID_TASK INTEGER PRIMARY KEY AUTOINCREMENT,
    $MODULE_ID INTEGER NOT NULL,
    $NAME TEXT NOT NULL,
    FOREIGN KEY ($MODULE_ID) REFERENCES $TABLE_MODULES($ID_MODULE)
  )
''';

