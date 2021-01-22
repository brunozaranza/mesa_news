import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';

abstract class IAuthViewModel {

  Future<String> checkUserExist();

  void onEmailButtonPressed();

  void onFacebookButtonPressed();

  void onRegisterButtonPressed();

  Future<ApiResponse<User>> onLoginDoneButtonPressed({
    String email,
    String password,
  });

  Future<ApiResponse<User>> onRegisterDoneButtonPressed({
    String name,
    String email,
    String password,
    String birthday,
  });

  void dispose();
}
