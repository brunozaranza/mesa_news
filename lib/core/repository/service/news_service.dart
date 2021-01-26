import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/repository/service/base_service.dart';

class NewsService {

  Future<ApiResponse<News>> fetchList(
      {String token, int currentPage, int perPage, String publishedAt}) async {

    ApiResponse response = await getDataList(
      token: token,
      endpoint: "/v1/client/news",
      currentPage: currentPage,
      perPage: perPage,
      publishedAt: publishedAt,
    );

    if (response.success) {
      return ApiResponse.success(News.fromJson(response.result));
    } else {
      return ApiResponse.error(response.msg);
    }
  }

  Future<ApiResponse<News>> fetchHighlightsList({String token}) async{
    ApiResponse response = await getDataList(
      token: token,
      endpoint: "/v1/client/news/highlights",
    );

    if (response.success) {
      return ApiResponse.success(News.fromJson(response.result));
    } else {
      return ApiResponse.error(response.msg);
    }
  }
}
