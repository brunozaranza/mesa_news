import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/viewmodel/ibase_viewmodel.dart';

abstract class INewsViewModel extends IBaseViewModel {
  Future<ApiResponse<News>> fetchList(
      {int currentPage, int perPage, String publishedAt});

  void onNewItemPressed(NewsItem item);

  List<NewsItem> get news;
  List<NewsItem> get highlightsNews;
  NewsItem get newSelected;
}
