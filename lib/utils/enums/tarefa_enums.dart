enum StatusTarefa { a_realizar, realizado }

extension StatusDescription on StatusTarefa {
  String get description {
    switch (this) {
      case StatusTarefa.a_realizar:
        return "A realizar";
      case StatusTarefa.realizado:
        return "Realizado";
      default:
        return "---";
    }
  }
}


