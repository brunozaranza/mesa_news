import 'dart:convert';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/user.dart';
import 'package:mesa_news/core/repository/service/base_service.dart';
import 'package:mesa_news/core/repository/service/iauth_service.dart';
import 'package:mesa_news/core/extension/string_extension.dart';

class AuthService implements IAuthService {
  @override
  Future<ApiResponse<User>> signIn({String email, String password}) async {
    Map<String, String> body = {'email': email, 'password': password};

    ApiResponse response = await postData(
      endpoint: "/v1/client/auth/signin",
      data: body,
    );

    if (response.success) {
      return ApiResponse.success(User.fromJson(response.result));
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  @override
  Future<ApiResponse<User>> signUp(
      {String name, String email, String password}) async {
    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password
    };

    ApiResponse response = await postData(
      endpoint: "/v1/client/auth/signup",
      data: body,
    );

    if (response.success) {
      return ApiResponse.success(User.fromJson(response.result));
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  @override
  Future<ApiResponse<User>> getFBProfile({String token}) async {
    ApiResponse response = await getFacebookProfile(token: token);

    if (response.success) {
      final profile = jsonDecode(response.result);

      return ApiResponse.success(User(
        name: profile['name'],
        email: profile['email'],
        password: "${profile['id']}.mn.${profile['email']}".md5(),
        token: token,
      ));

    } else {
      return ApiResponse.error(response.msg);
    }
  }
}
