import 'package:email_validator/email_validator.dart';

mixin ValidatorViewModel {
  String emailValidator(email) {
    final bool isEmailValid = EmailValidator.validate(email);

    return isEmailValid ? null : "Digite um e-mail válido";
  }

  String passwordValidator(password) {
    return password.isEmpty ? "Digite a senha" : null;
  }

  String registerConfirmPasswordValidator(String p1, String p2) {
    if (p1.isEmpty) return "Repita a senha";

    return (p1 != p2) ? "Senhas diferentes" : null;
  }

  String registerPasswordValidator(String password) {
    if (password.isEmpty) return "Digite a senha";

    return (password.length < 6) ? "Senha deve 6 dígitos ou mais" : null;
  }

  String registerNameValidator(String name) {
    return name.isEmpty ? "Digite seu nome" : null;
  }
}