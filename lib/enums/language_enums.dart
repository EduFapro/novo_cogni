enum Language { portuguese, spanish }

extension LanguageDescription on Language {
  String get description {
    switch (this) {
      case Language.portuguese:
        return "Portuguese";
      case Language.spanish:
        return "Spanish";
      default:
        return "Unknown";
    }
  }
}
