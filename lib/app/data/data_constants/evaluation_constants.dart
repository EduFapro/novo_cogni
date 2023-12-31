import 'package:novo_cogni/app/data/data_constants/participant_constants.dart';

import 'database_constants.dart';
import 'evaluator_constants.dart';

const ID_EVALUATION = "evaluation_id";
const EVALUATION_DATE = "evaluation_date";
const ID_EVALUATOR_FK = "evaluator_id";
const ID_PARTICIPANT_FK = "participant_id";
const EVALUATION_STATUS = "status";

const SCRIPT_CREATE_TABLE_EVALUATIONS = '''
  CREATE TABLE $TABLE_EVALUATIONS
  (
    $ID_EVALUATION INTEGER PRIMARY KEY AUTOINCREMENT,
    $EVALUATION_DATE TIMESTAMP NOT NULL,
    $ID_EVALUATOR_FK INTEGER NOT NULL,
    $ID_PARTICIPANT_FK INTEGER UNIQUE NOT NULL,
    $EVALUATION_STATUS TEXT NOT NULL,
    FOREIGN KEY ($ID_EVALUATOR_FK) REFERENCES $TABLE_EVALUATORS($ID_EVALUATOR),
    FOREIGN KEY ($ID_PARTICIPANT_FK) REFERENCES $TABLE_PARTICIPANTS($ID_PARTICIPANT)
  )
''';
