import 'package:novo_cogni/app/data/data_constants/participante_constants.dart';
import 'avaliador_constants.dart';
import 'database_constants.dart';

const ID_AVALIACAO = "avaliacao_id";
const DATA_AVALIACAO = "data_avaliacao";
const ID_AVALIADOR_FK = "avaliador_id";
const ID_PARTICIPANTE_FK = "participante_id";
const STATUS = "status";

const SCRIPT_CREATE_TABELA_AVALIACOES = '''
  CREATE TABLE $TABELA_AVALIACOES
  (
    $ID_AVALIACAO INTEGER PRIMARY KEY,
    $DATA_AVALIACAO DATE,
    $ID_AVALIADOR_FK INTEGER,
    $ID_PARTICIPANTE_FK INTEGER,
        $STATUS TEXT,
    FOREIGN KEY ($ID_AVALIADOR_FK) REFERENCES $TABELA_AVALIADORES($ID_AVALIADOR),
    FOREIGN KEY ($ID_PARTICIPANTE_FK) REFERENCES $TABELA_PARTICIPANTES($ID_PARTICIPANTE)
  )
''';
