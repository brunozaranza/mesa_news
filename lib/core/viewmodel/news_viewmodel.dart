import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/repository/service/inews_service.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
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

    _injectNews(response.result);

    _updateWithFavorites(response.result);

    return response;
  }

  _injectNews(News news){
    List<NewsItem> list = List();
    for (NewsItem item in news.news) {
      if (item.highlight) list.add(item);
    }
    GetIt.I<NewsStore>().setHighlightsNews(list);
    GetIt.I<NewsStore>().setNews(news.news);
  }

  _updateWithFavorites(News news) async {
    List<String> favorites = await getSavedFavoriteNews();
    for (String favoriteTitle in favorites) {
      news.news.where((element) => element.title == favoriteTitle)
          .first.favorite = true;
    }
  }

  @override
  List<NewsItem> get highlightsNews => GetIt.I<NewsStore>().highlightsNews;

  @override
  List<NewsItem> get news {
    bool isFavoriteSelected = GetIt.I<FilterStore>().isJustFavorites;

    if (!isFavoriteSelected) return GetIt.I<NewsStore>().news;

    List<NewsItem> list = List();

    for (NewsItem item in GetIt.I<NewsStore>().news) {
      if (item.favorite?? false) list.add(item);
    }

    return list;
  }

  @override
  NewsItem get newSelected => GetIt.I<NewsStore>().newSelected;

  @override
  void onNewItemPressed(item) {
    GetIt.I<NewsStore>().setNewSelected(item);
    navigateTo(route: '/feed/new');
  }

  @override
  void dispose() {}
}
