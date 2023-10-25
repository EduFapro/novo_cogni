enum Status { a_iniciar, em_progresso, terminado }

extension StatusExtension on Status {
  String get description {
    switch (this) {
      case Status.a_iniciar:
        return "A iniciar";
      case Status.em_progresso:
        return "Em progresso";
      case Status.terminado:
        return "Terminado";
      default:
        return "Unknown";
    }
  }
}
