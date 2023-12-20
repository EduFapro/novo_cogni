
import 'database_constants.dart';

const ID_MODULE = "module_id";
const TITLE = "title";

const SCRIPT_CREATE_TABLE_MODULES = '''
  CREATE TABLE $TABLE_MODULES
  (
    $ID_MODULE INTEGER PRIMARY KEY AUTOINCREMENT,
    $TITLE TEXT NOT NULL
  )
''';

final SCRIPT_INSERT_MODULES = '''
    INSERT INTO $TABLE_MODULES
        ($ID_MODULE, $TITLE) VALUES
        ${list_modules.map((module) => "(${module.moduleID}, '${module.title}')").join(", ")};
''';
