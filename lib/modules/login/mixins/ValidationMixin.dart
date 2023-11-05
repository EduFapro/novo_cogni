mixin ValidationMixin {
  String? validateEmail(String? value) =>
      !value!.contains('@') ? 'Please enter a valid email' : null;

  String? validatePassword(String? value) =>
      (value!.length < 4) ? 'Password must be at least 4 characters' : null;
}
