import '../../domain/use_cases/modulos.dart';
import 'database_constants.dart';

const ID_MODULO = "modulo_id";
const TAREFAS = "tarefas";
const TITULO = "titulo";

const SCRIPT_CREATE_TABELA_MODULOS = '''
  CREATE TABLE $TABELA_MODULOS
  (
    $ID_MODULO INTEGER PRIMARY KEY,
    $TITULO TEXT,
    $TAREFAS TEXT
    
  )
''';
final SCRIPT_INSERT_MODULOS = '''
    INSERT INTO $TABELA_MODULOS
        ($ID_MODULO, $TITULO) VALUES
        ${lista_modulos.map((modulo) => "(${modulo.moduloID}, '${modulo.titulo}')").join(", ")};
''';
