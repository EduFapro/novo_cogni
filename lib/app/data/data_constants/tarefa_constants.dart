import 'database_constants.dart';

const ID_TAREFA = "tarefa_id";
const NOME = "nome";
const STATUS = "status";

const SCRIPT_CREATE_TABELA_TAREFAS = '''
  CREATE TABLE $TABELA_TAREFAS
  (
    $ID_TAREFA INTEGER PRIMARY KEY,
    $NOME TEXT,
    $STATUS TEXT
  )
''';
