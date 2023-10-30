import 'package:novo_cogni/data/data_constants/participante_constants.dart';

import 'avaliador_constants.dart';
import 'constantes_gerais.dart';

const ID_AVALIACAO = "avaliacao_id";
const ID_AVALIADOR_FK = "avaliador_id";
const ID_PARTICIPANTE_FK = "participante_id";

const SCRIPT_CREATE_TABELA_AVALIACOES = '''
  CREATE TABLE $TABELA_AVALIACOES
  (
    $ID_AVALIACAO INTEGER PRIMARY KEY,
    $ID_AVALIADOR_FK INTEGER,
    $ID_PARTICIPANTE_FK INTEGER,
    FOREIGN KEY ($ID_AVALIADOR_FK) REFERENCES $TABELA_AVALIADORES($ID_AVALIADOR),
    FOREIGN KEY ($ID_PARTICIPANTE_FK) REFERENCES $TABELA_PARTICIPANTES($ID_PARTICIPANTE)
  )
''';
