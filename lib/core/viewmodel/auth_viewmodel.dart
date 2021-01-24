import 'package:email_validator/email_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/repository/service/iauth_service.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/iauth_viewmodel.dart';
import 'package:mesa_news/core/extension/string_extension.dart';

class AuthViewModel implements IAuthViewModel {

  @override
  void dispose() {}

  @override
  Future<String> checkUserExist() async {
    String token = await getSavedToken();
    if (token.isNotEmpty) {
      GetIt.I<UserStore>().setUser(User(token: token));
      navigateReplaceAllTo(route: "/feed");
    }
    return token;
  }

  @override
  void onEmailButtonPressed() {
    navigateTo(route: '/auth');
  }

  @override
  void onFacebookButtonPressed() {
    print("facebook");
  }

  @override
  void onRegisterButtonPressed() {
    navigateTo(route: '/register');
  }

  @override
  Future<ApiResponse<User>> onLoginDoneButtonPressed({
    String email,
    String password,
  }) async {
    ApiResponse<User> response = await GetIt.I<IAuthService>()
        .signIn(email: email, password: password.md5());

    if (response.success) {
      GetIt.I<UserStore>().setUser(response.result);
      saveToken(response.result.token);
      navigateReplaceAllTo(route: '/feed');
    }

    return response;
  }

  @override
  Future<ApiResponse<User>> onRegisterDoneButtonPressed(
      {String name, String email, String password, String birthday}) async {
    ApiResponse<User> response = await GetIt.I<IAuthService>()
        .signUp(name: name, email: email, password: password.md5());

    return response;
  }

  @override
  String emailValidator(email) {
    final bool isEmailValid = EmailValidator
        .validate(email);

    return isEmailValid ? null : "Digite um e-mail válido";
  }

  @override
  String passwordValidator(password) {
    return password.isEmpty ? "Digite a senha" : null;
  }

  @override
  String registerConfirmPasswordValidator(String p1, String p2) {
    if (p1.isEmpty) return "Repita a senha";

    return (p1 != p2) ?"Senhas diferentes" : null;
  }

  @override
  String registerPasswordValidator(String password) {
    if (password.isEmpty) return "Digite a senha";

    return (password.length < 6) ? "Senha deve 6 dígitos ou mais" : null;
  }

  @override
  String registerNameValidator(String name) {
    return name.isEmpty ? "Digite seu nome" : null;
  }
}
