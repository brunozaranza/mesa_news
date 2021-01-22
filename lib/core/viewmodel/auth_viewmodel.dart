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
  Future<String> checkUserExist() async {
    String token = await getToken();
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
  void dispose() {}
}
