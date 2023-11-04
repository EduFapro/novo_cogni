enum Idioma { portugues, espanhol }

extension IdiomaDescription on Idioma {
  String get description {
    switch (this) {
      case Idioma.portugues:
        return "Português";
      case Idioma.espanhol:
        return "Espanhol";
      default:
        return "Desconhecido";
    }
  }
}
