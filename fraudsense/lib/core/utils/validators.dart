class Validators {
  static bool validatePassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');

    return password.isNotEmpty && regex.hasMatch(password);
  }
}
