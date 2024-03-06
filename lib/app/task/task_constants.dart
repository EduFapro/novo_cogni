import '../database_constants.dart';
import '../module/module_constants.dart';

const ID_TASK = "task_id";
const TITLE = "name";
const MODULE_ID = "module_id";
const MODE = "mode";
const POSITION = "position";
const IMAGE_PATH = "image_path";
const TIME_FOR_COMPLETION = "time_for_completion";

const SCRIPT_CREATE_TABLE_TASKS = '''
  CREATE TABLE $TABLE_TASKS
(
  $ID_TASK INTEGER PRIMARY KEY AUTOINCREMENT,
  $MODULE_ID INTEGER NOT NULL,
  $TITLE TEXT NOT NULL,
  $MODE INT NOT NULL CHECK($MODE >= 0 AND $MODE <= 1),
  $POSITION INT NOT NULL,
  $IMAGE_PATH TEXT,
  $TIME_FOR_COMPLETION INTEGER NOT NULL,
  FOREIGN KEY ($MODULE_ID) REFERENCES $TABLE_MODULES($ID_MODULE)
)

''';
