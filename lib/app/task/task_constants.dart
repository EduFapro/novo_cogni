import '../database_constants.dart';
import '../module/module_constants.dart';

const ID_TASK = "task_id";
const TITLE = "name";
const MODULE_ID = "module_id";
const MODE = "mode";
const POSITION = "position";
const IMAGE_PATH = "image_path";
const TIME_FOR_COMPLETION = "time_for_completion";
const MAY_REPEAT_PROMPT = "may_repeat_prompt";

const SCRIPT_CREATE_TABLE_TASKS = '''
 CREATE TABLE tasks
(
  task_id INTEGER PRIMARY KEY AUTOINCREMENT,
  module_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  mode INT NOT NULL,
  position INT NOT NULL,
  image_path TEXT,
  may_repeat_prompt INT NOT NULL,
  time_for_completion INTEGER NOT NULL,
  FOREIGN KEY (module_id) REFERENCES modules(module_id),
  CHECK(mode >= 0 AND mode <= 1),
  CHECK(may_repeat_prompt >= 0 AND may_repeat_prompt <= 1)
)
''';
