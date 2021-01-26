import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/repository/database/shared.dart';
import 'package:mesa_news/core/repository/service/auth_service.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mesa_news/core/viewmodel/base_viewmodel_contract.dart';
import 'package:mesa_news/core/viewmodel/validator_viewmodel.dart';
import 'package:mesa_news/locator.dart';

class AuthViewModel with ValidatorViewModel implements BaseViewModelContract{

  @override
  void dispose() {}

  Future<String> checkUserExist() async {
    String token = await getSavedToken();
    if (token.isNotEmpty) {
      getServiceLocator<UserStore>().setUser(User(token: token));
      navigateReplaceAllTo(route: "/feed");
    }
    return token;
  }

  void onEmailButtonPressed() {
    navigateTo(route: '/auth');
  }

  _openFeed(ApiResponse response) {
    if(response.success) {
      getServiceLocator<UserStore>().setUser(response.result);
      saveToken(response.result.token);
      navigateReplaceAllTo(route: '/feed');
    }
  }

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
        ApiResponse<User> fbResponse = await getServiceLocator<AuthService>()
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

  void onRegisterButtonPressed() {
    navigateTo(route: '/register');
  }

  Future<ApiResponse<User>> onLoginDoneButtonPressed({
    String email,
    String password,
  }) async {
    ApiResponse<User> response = await getServiceLocator<AuthService>()
        .signIn(email: email, password: password.md5());

    _openFeed(response);

    return response;
  }

  Future<ApiResponse<User>> onRegisterDoneButtonPressed(
      {String name, String email, String password, String birthday}) async {
    ApiResponse<User> response = await getServiceLocator<AuthService>()
        .signUp(name: name, email: email, password: password.md5());

    return response;
  }
}
