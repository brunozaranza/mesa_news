import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/viewmodel/ibase_viewmodel.dart';

abstract class IAuthViewModel extends IBaseViewModel {

  Future<String> checkUserExist();

  void onEmailButtonPressed();

  void onFacebookButtonPressed();

  void onRegisterButtonPressed();

  String emailValidator(String email);
  String passwordValidator(String password);

  String registerNameValidator(String name);
  String registerPasswordValidator(String password);
  String registerConfirmPasswordValidator(String p1, String p2);

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
}
