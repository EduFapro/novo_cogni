import 'package:equatable/equatable.dart';
import '../../data/data_constants/avaliador_constants.dart';
import '../../enums/pessoa_enums.dart';

class AvaliadorEntity extends Equatable {
  final int? avaliadorID;
  final String nome;
  final String sobrenome;
  final DateTime dataNascimento;
  final Sexo sexo;
  final String especialidade;
  final String cpfOuNif;
  final String email;
  late String password;
  final bool eh_avaliador = false;
  bool primeiro_login;

  AvaliadorEntity(
      {this.avaliadorID,
      required this.nome,
      required this.sobrenome,
      required this.dataNascimento,
      required this.sexo,
      required this.especialidade,
      required this.cpfOuNif,
      required this.email,
      required this.password,
      required this.primeiro_login});

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
        email = map[EMAIL_AVALIADOR] ?? '',
        password = map[PASSWORD_AVALIADOR] ?? '0000',
        primeiro_login = map[PRIMEIRO_LOGIN] == 0 ? false : true;

  Map<String, Object?> toMap() {
    return {
      ID_AVALIADOR: avaliadorID,
      NOME_AVALIADOR: nome,
      SOBRENOME_AVALIADOR: sobrenome,
      DATA_NASCIMENTO_AVALIADOR: dataNascimento.toIso8601String(),
      SEXO_AVALIADOR: sexo == Sexo.homem ? 'Homem' : 'Mulher',
      CPF_OU_NIF_AVALIADOR: cpfOuNif,
      EMAIL_AVALIADOR: email,
      PASSWORD_AVALIADOR: password,
      PRIMEIRO_LOGIN: primeiro_login ? 1 : 0
    };
  }

  @override
  String toString() {
    return "Nome avaliador: $nome $sobrenome";
  }

  @override
  List<Object?> get props => [avaliadorID];
}
