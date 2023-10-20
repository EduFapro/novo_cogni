import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../data/data_constants/participante_constants.dart';
import '../../utils/enums/pessoa_enums.dart';

class ParticipanteEntity extends Equatable {
  final int? participanteID;
  final String nome;
  final String sobrenome;
  final DateTime dataNascimento;
  final Sexo sexo;
  final Escolaridade escolaridade;

  ParticipanteEntity({
    this.participanteID,
    required this.nome,
    required this.sobrenome,
    required this.dataNascimento,
    required this.sexo,
    required this.escolaridade,
  });

  ParticipanteEntity.fromMap(Map<String, dynamic> map) :
        participanteID = map[ID_PARTICIPANTE] as int?,
        nome = map[NOME_PARTICIPANTE] ?? '',
        sobrenome = map[SOBRENOME_PARTICIPANTE] ?? '',
        dataNascimento = (map[DATA_NASCIMENTO_PARTICIPANTE] != null) ? DateTime.parse(map[DATA_NASCIMENTO_PARTICIPANTE]) : DateTime.now(),
        sexo = (map[SEXO_PARTICIPANTE] == 'Homem') ? Sexo.homem : Sexo.mulher,
        escolaridade = (map[ESCOLARIDADE_PARTICIPANTE] != null) ? Escolaridade.values.firstWhere((e) => e.toString().split('.').last == map[ESCOLARIDADE_PARTICIPANTE]) : Escolaridade.outros;

  Map<String, Object?> toMap() {
    return {
      if (participanteID != null) ID_PARTICIPANTE: participanteID,
      NOME_PARTICIPANTE: nome,
      SOBRENOME_PARTICIPANTE: sobrenome,
      DATA_NASCIMENTO_PARTICIPANTE: dataNascimento.toIso8601String(),
      SEXO_PARTICIPANTE: sexo == Sexo.homem ? 'Homem' : 'Mulher',
      ESCOLARIDADE_PARTICIPANTE: escolaridade.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return "Nome participante: $nome $sobrenome";
  }

  @override
  List<Object?> get props => [participanteID];
}
