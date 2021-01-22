import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';

abstract class IAuthService {
  Future<ApiResponse<User>> signIn({String email, String password});
  Future<ApiResponse<User>> signUp({String name, String email, String password});
}