import 'avaliacao_constants.dart';
import 'constantes_gerais.dart';

const ID_MODULO = "modulo_id";
const DATA_MODULO = "data_modulo";
const PONTUACAO_MODULO = "pontuacao";
const ID_AVALIACAO_FK = "avaliacao_id";
const STATUS = "status";


const SCRIPT_CREATE_TABELA_MODULOS = '''
  CREATE TABLE $TABELA_MODULOS
  (
    $ID_MODULO INTEGER PRIMARY KEY,
    $DATA_MODULO DATE,
    $PONTUACAO_MODULO INTEGER,
    $ID_AVALIACAO_FK INTEGER,
    $STATUS TEXT,
    FOREIGN KEY ($ID_AVALIACAO_FK) REFERENCES $TABELA_AVALIACOES($ID_AVALIACAO)
  )
''';
