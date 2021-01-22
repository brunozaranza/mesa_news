import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';

abstract class INewsService {
  Future<ApiResponse<News>> fetchList(
      {String token, int currentPage, int perPage, String publishedAt});

  Future<ApiResponse<News>> fetchHighlightsList({String token});
}
