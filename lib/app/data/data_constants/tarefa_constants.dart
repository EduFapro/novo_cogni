import 'database_constants.dart';
import 'modulo_constants.dart';

const ID_TAREFA = "tarefa_id";
const NOME = "nome";
const STATUS = "status";
const MODULO_ID = "modulo_id";

const SCRIPT_CREATE_TABELA_TAREFAS = '''
  CREATE TABLE $TABELA_TAREFAS
  (
    $ID_TAREFA INTEGER PRIMARY KEY AUTOINCREMENT,
    $MODULO_ID INTEGER,
    $NOME TEXT,
    $STATUS TEXT,
    FOREIGN KEY ($MODULO_ID) REFERENCES $TABELA_MODULOS($ID_MODULO)
  )
''';

