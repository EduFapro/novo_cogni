import '../../domain/use_cases/modulos.dart';
import 'database_constants.dart';
import 'modulo_constants.dart';

const ID_TAREFA = "tarefa_id";
const NOME = "nome";
const MODULO_ID = "modulo_id";

const SCRIPT_CREATE_TABELA_TAREFAS = '''
  CREATE TABLE $TABELA_TAREFAS
  (
    $ID_TAREFA INTEGER PRIMARY KEY AUTOINCREMENT,
    $MODULO_ID INTEGER,
    $NOME TEXT,
    FOREIGN KEY ($MODULO_ID) REFERENCES $TABELA_MODULOS($ID_MODULO)
  )
''';

final SCRIPT_INSERT_TAREFAS = '''
    INSERT INTO $TABELA_TAREFAS
        ($MODULO_ID, $NOME) VALUES
        ${lista_tarefas.map((tarefa) => "(${tarefa.moduloID}, '${tarefa.nome}')").join(", ")};
''';
