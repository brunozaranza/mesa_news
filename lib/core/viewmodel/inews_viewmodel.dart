import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';

abstract class INewsViewModel {
  Future<ApiResponse<News>> fetchList(
      {int currentPage, int perPage, String publishedAt});

  Future<ApiResponse<News>> fetchHighlightsList();

  List<NewsItem> get news;
  List<NewsItem> get highlightsNews;
}
