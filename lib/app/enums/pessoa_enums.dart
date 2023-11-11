enum Sexo { homem, mulher }

enum Escolaridade {
  fundamental_incompleto,
  fundamental_completo,
  medio_incompleto,
  medio_completo,
  superior_incompleto,
  superior_completo,
  outros
}

enum Lateralidade { canhoto, destro, ambidestro }


extension SexoDesc on Sexo {
  String get description {
    switch (this) {
      case Sexo.homem:
        return "Homem";
      case Sexo.mulher:
        return "Mulher";
      default:
        return "---";
    }
  }
}

extension EscolaridadeDesc on Escolaridade {
  String get description {
    switch (this) {
      case Escolaridade.fundamental_incompleto:
        return "Fundamental Incompleto";
      case Escolaridade.fundamental_completo:
        return "Fundamental Completo";
      case Escolaridade.medio_incompleto:
        return "Médio Incompleto";
      case Escolaridade.medio_completo:
        return "Médio Completo";
      case Escolaridade.superior_incompleto:
        return "Superior Incompleto";
      case Escolaridade.superior_completo:
        return "Superior Completo";
      case Escolaridade.outros:
        return "Outros";
      default:
        return "---";
    }
  }
}

extension LateralidadeDescription on Lateralidade {
  String get description {
    switch (this) {
      case Lateralidade.canhoto:
        return "Canhoto";
      case Lateralidade.destro:
        return "Destro";
      case Lateralidade.ambidestro:
        return "Ambidestro";
      default:
        return "---";
    }
  }
}
