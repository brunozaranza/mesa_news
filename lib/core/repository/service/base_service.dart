import 'package:dio/dio.dart';
import 'package:mesa_news/core/model/api_error.dart';
import 'package:mesa_news/core/model/api_response.dart';

final baseUrl = "https://mesa-news-api.herokuapp.com";

final Map<String, String> _headers = {
  'Content-Type': 'application/json',
};

Future<ApiResponse> getDataList(
    {String token, String endpoint, int currentPage, int perPage, String publishedAt}) async {
  try {
    var dio = Dio();

    dio.options.headers["authorization"] = "token $token";

    String url = "$baseUrl$endpoint";

    if (currentPage != null || perPage != null || publishedAt != null) {
      url = "?$url${currentPage!=null?"&$currentPage":""}"
          "${perPage!=null?"&$perPage":""}"
          "${publishedAt!=null?"&$publishedAt":""}";
    }

    Response response = await dio.get(url,
      options: Options(
        headers: _headers,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.success(response.data);
    } else {
      return ApiResponse.error(response.statusMessage);
    }
  } on DioError catch (e) {
    return _dioError(e.response.data);
  }
}

Future<ApiResponse> postData({String endpoint, dynamic data}) async {
  try {
    var dio = Dio();

    Response response = await dio.post(
      "$baseUrl$endpoint",
      data: data,
      options: Options(
        headers: _headers,
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.success(response.data);
    } else {
      return ApiResponse.error(response.statusMessage);
    }
  } on DioError catch (e) {
    return _dioError(e.response.data);
  }
}

Future<ApiResponse> getFacebookProfile({String token}) async {
  try {
    var dio = Dio();

    final response = await dio.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.success(response.data);
    } else {
      return ApiResponse.error(response.statusMessage);
    }
  } on DioError catch (e) {
    return _dioError(e.response.data);
  }
}

ApiResponse _dioError (Map<String, dynamic> map) {
  if(map.containsKey("errors")) {
    return ApiResponse.error(
        ApiError
            .fromJson(map).errors.first.message);
  } else {
    return ApiResponse.error(ApiErrorItem
        .fromJson(map)
        .message);
  }
}
