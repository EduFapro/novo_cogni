import 'avaliacao_constants.dart';
import 'database_constants.dart';
import 'modulo_constants.dart';

const ID_AVALIACAO_FK = "avaliacao_id";
const ID_MODULO_FK = "modulo_id";


const SCRIPT_CREATE_TABELA_AVALIACAO_MODULOS = '''
  CREATE TABLE $TABELA_AVALIACAO_MODULOS
  (
    $ID_AVALIACAO_FK INTEGER,
    $ID_MODULO_FK INTEGER,
    PRIMARY KEY ($ID_AVALIACAO_FK, $ID_MODULO_FK),
    FOREIGN KEY ($ID_AVALIACAO_FK) REFERENCES $TABELA_AVALIACOES($ID_AVALIACAO),
    FOREIGN KEY ($ID_MODULO_FK) REFERENCES $TABELA_MODULOS($ID_MODULO)
  )
''';
