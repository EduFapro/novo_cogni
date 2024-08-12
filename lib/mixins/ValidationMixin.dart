mixin ValidationMixin {
  String? validateEmail(String? value) =>
      !value!.contains('@') ? 'Please enter a valid email' : null;

  String? validatePassword(String? value) =>
      (value!.length < 4) ? 'Senha deve ter ao menos 4 caracteres' : null;

  String? validateSecondPassword(String? secondPassword, String firstPassword) {
    if (secondPassword != firstPassword) {
      return "Senhas são diferentes";
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira nome e sobrenome';
    }

    // This regex allows letters, spaces, apostrophes, and hyphens
    // which can occur in names like O'Neill or Anne-Marie.
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return 'Nome deve ter somente letras';
    }

    List<String> nameParts = value.trim().split(RegExp(r'\s+'));
    if (nameParts.length < 2) {
      return 'Insira nome e sobrenome';
    }

    return null;
  }

}
