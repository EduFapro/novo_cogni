enum StatusModulo { a_iniciar, em_progresso, terminado }

List items = [
  'Contar História',
  'Contar até 50',
  'Roubo de biscoitos'
];


extension StatusDescription on StatusModulo {
  String get description {
    switch (this) {
      case StatusModulo.a_iniciar:
        return "A iniciar";
      case StatusModulo.em_progresso:
        return "Em progresso";
      case StatusModulo.terminado:
        return "Terminado";
      default:
        return "Unknown";
    }
  }
}
