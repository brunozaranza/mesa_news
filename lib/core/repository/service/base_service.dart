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
    return ApiResponse.error(
        ApiError.fromJson(e.response.data).errors.first.message);
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
    return ApiResponse.error(
        ApiError.fromJson(e.response.data).errors.first.message);
  }
}
