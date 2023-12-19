enum StatusTarefa { iniciar, feito }

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


