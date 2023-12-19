enum StatusTarefa { iniciar, feito }
enum TarefaMode {
  play,
  record,
}


extension StatusDescription on StatusTarefa {
  String get description {
    switch (this) {
      case StatusTarefa.iniciar:
        return "Iniciar";
      case StatusTarefa.feito:
        return "Feito";
      default:
        return "---";
    }
  }
}

extension Mode on TarefaMode {
  String get description {
    switch (this) {
      case TarefaMode.play:
        return "Iniciar";
      case TarefaMode.record:
        return "Feito";
      default:
        return "---";
    }
  }
}

