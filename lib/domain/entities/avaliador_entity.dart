import 'package:equatable/equatable.dart';
import '../../data/data_constants/avaliador_constants.dart';
import '../../utils/enums/pessoa_enums.dart';

class AvaliadorEntity extends Equatable {
  final int? avaliadorID;
  final String nome;
  final String sobrenome;
  final DateTime dataNascimento;
  final Sexo sexo;
  final String especialidade;
  final String cpfOuNif;
  final String email;

  AvaliadorEntity({
    this.avaliadorID,
    required this.nome,
    required this.sobrenome,
    required this.dataNascimento,
    required this.sexo,
    required this.especialidade,
    required this.cpfOuNif,
    required this.email,
  });

  AvaliadorEntity.fromMap(Map<String, dynamic> map)
      : avaliadorID = map[ID_AVALIADOR] as int?,
        nome = map[NOME_AVALIADOR] ?? '',
        sobrenome = map[SOBRENOME_AVALIADOR] ?? '',
        dataNascimento = (map[DATA_NASCIMENTO_AVALIADOR] != null)
            ? DateTime.parse(map[DATA_NASCIMENTO_AVALIADOR])
            : DateTime.now(),
        sexo = (map[SEXO_AVALIADOR] == 'Homem') ? Sexo.homem : Sexo.mulher,
        especialidade = map[ESPECIALIDADE_AVALIADOR] ?? '',
        cpfOuNif = map[CPF_OU_NIF_AVALIADOR] ?? '',
        email = map[EMAIL_AVALIADOR] ?? '';

  Map<String, Object?> toMap() {
    return {
      ID_AVALIADOR: avaliadorID,
      NOME_AVALIADOR: nome,
      SOBRENOME_AVALIADOR: sobrenome,
      DATA_NASCIMENTO_AVALIADOR: dataNascimento.toIso8601String(),
      SEXO_AVALIADOR: sexo == Sexo.homem ? 'Homem' : 'Mulher',
      CPF_OU_NIF_AVALIADOR: cpfOuNif,
      EMAIL_AVALIADOR: email,
    };
  }

  @override
  String toString() {
    return "Nome avaliador: $nome $sobrenome";
  }

  @override
  List<Object?> get props => [avaliadorID];
}
