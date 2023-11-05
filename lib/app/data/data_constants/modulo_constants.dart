import 'database_constants.dart';

const ID_MODULO = "modulo_id";
const DATA_MODULO = "data_modulo";
const PONTUACAO_MODULO = "pontuacao";
const STATUS = "status";
const TAREFAS = "tarefas";

const SCRIPT_CREATE_TABELA_MODULOS = '''
  CREATE TABLE $TABELA_MODULOS
  (
    $ID_MODULO INTEGER PRIMARY KEY,
    $DATA_MODULO DATE,
    $PONTUACAO_MODULO INTEGER,
    $STATUS TEXT,
    $TAREFAS TEXT
  
  )
''';
