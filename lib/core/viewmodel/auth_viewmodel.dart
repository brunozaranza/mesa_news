import 'package:email_validator/email_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/repository/service/auth_service.dart';
import 'package:mesa_news/core/repository/service/iauth_service.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/iauth_viewmodel.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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

  _openFeed(ApiResponse response) {
    if(response.success) {
      GetIt.I<UserStore>().setUser(response.result);
      saveToken(response.result.token);
      navigateReplaceAllTo(route: '/feed');
    }
  }

  @override
  Future<ApiResponse<User>> onFacebookButtonPressed() async {
    var login = FacebookLogin();
    login.loginBehavior = FacebookLoginBehavior.webViewOnly;

    var result = await login.logIn(['email']);

    ApiResponse<User> response;

    switch (result.status) {
      case FacebookLoginStatus.error:
        response = ApiResponse.error("Erro de autenticação");
        break;
      case FacebookLoginStatus.cancelledByUser:
        response = ApiResponse.error("");
        break;
      case FacebookLoginStatus.loggedIn:
        ApiResponse<User> fbResponse = await GetIt.I<IAuthService>()
            .getFBProfile(token: result.accessToken.token);
        response = ApiResponse.success(fbResponse.result);
        break;
      default:
        response = ApiResponse.error("Erro desconhecido");
        break;
    }

    if (response.success) {
      onLoginDoneButtonPressed(
          email: response.result.email, password: response.result.password).then((apiLogin) {
        if (apiLogin.success) {
          _openFeed(apiLogin);
        }
        else {
          onRegisterDoneButtonPressed(
              name: response.result.name,
              email: response.result.email,
              password: response.result.password).then((apiRegister) {
                _openFeed(apiRegister);
          });
        }
      });
    }

    return response;
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

    _openFeed(response);

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
    final bool isEmailValid = EmailValidator.validate(email);

    return isEmailValid ? null : "Digite um e-mail válido";
  }

  @override
  String passwordValidator(password) {
    return password.isEmpty ? "Digite a senha" : null;
  }

  @override
  String registerConfirmPasswordValidator(String p1, String p2) {
    if (p1.isEmpty) return "Repita a senha";

    return (p1 != p2) ? "Senhas diferentes" : null;
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
