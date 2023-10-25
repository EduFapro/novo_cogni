import 'avaliacao_constants.dart';
import 'constantes_gerais.dart';

const ID_ATIVIDADE = "atividade_id";
const DATA_ATIVIDADE = "data_atividade";
const PONTUACAO_ATIVIDADE = "pontuacao";
const ID_AVALIACAO_FK = "avaliacao_id";
const STATUS = "status";


const SCRIPT_CREATE_TABELA_ATIVIDADES = '''
  CREATE TABLE $TABELA_ATIVIDADES
  (
    $ID_ATIVIDADE INTEGER PRIMARY KEY,
    $DATA_ATIVIDADE DATE,
    $PONTUACAO_ATIVIDADE INTEGER,
    $ID_AVALIACAO_FK INTEGER,
    $STATUS TEXT,
    FOREIGN KEY ($ID_AVALIACAO_FK) REFERENCES $TABELA_AVALIACOES($ID_AVALIACAO)
  )
''';
