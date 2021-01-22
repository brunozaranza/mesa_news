import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/repository/service/inews_service.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';

class NewsViewModel implements INewsViewModel {
  @override
  Future<ApiResponse<News>> fetchList(
      {int currentPage, int perPage, String publishedAt}) async {

    ApiResponse<News> response = await GetIt.I<INewsService>().fetchList(
        token: GetIt.I<UserStore>().user.token,
        currentPage: currentPage,
        perPage: perPage,
        publishedAt: publishedAt);

    return response;
  }

  @override
  Future<ApiResponse<News>> fetchHighlightsList() async {
    ApiResponse<News> response = await GetIt.I<INewsService>().fetchHighlightsList(
        token: GetIt.I<UserStore>().user.token);

    return response;
  }

  @override
  List<NewsItem> get highlightsNews => GetIt.I<NewsStore>().highlightsNews;

  @override
  List<NewsItem> get news => GetIt.I<NewsStore>().news;
}
