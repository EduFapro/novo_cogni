import 'database_constants.dart';

const ID_EVALUATOR = "evaluator_id";
const EVALUATOR_NAME = "name";
const EVALUATOR_SURNAME = "surname";
const BIRTH_DATE_EVALUATOR = "birth_date";
const GENDER_EVALUATOR = "gender";
const SPECIALTY_EVALUATOR = "specialty";
const CPF_OR_NIF_EVALUATOR = "cpf_or_nif";
const EMAIL_EVALUATOR = "email";
const PASSWORD_EVALUATOR = "password";
const FIRST_LOGIN = "first_login";
const IS_ADMIN = "is_admin";

const SCRIPT_CREATE_TABLE_EVALUATORS = '''
  CREATE TABLE $TABLE_EVALUATORS
  (
    $ID_EVALUATOR INTEGER PRIMARY KEY AUTOINCREMENT,
    $EVALUATOR_NAME TEXT NOT NULL,
    $EVALUATOR_SURNAME TEXT NOT NULL,
    $BIRTH_DATE_EVALUATOR TIMESTAMP,
    $GENDER_EVALUATOR TEXT CHECK($GENDER_EVALUATOR IN ('Male', 'Female')),
    $SPECIALTY_EVALUATOR TEXT,
    $CPF_OR_NIF_EVALUATOR TEXT,
    $EMAIL_EVALUATOR TEXT NOT NULL UNIQUE,
    $PASSWORD_EVALUATOR TEXT NOT NULL DEFAULT '0000',
    $FIRST_LOGIN INTEGER NOT NULL DEFAULT 0,
    $IS_ADMIN INTEGER NOT NULL DEFAULT 0
  )
''';
