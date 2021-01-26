import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/repository/database/shared.dart';
import 'package:mesa_news/core/repository/service/news_service.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/base_viewmodel_contract.dart';
import 'package:mesa_news/locator.dart';

class NewsViewModel implements BaseViewModelContract {

  @override
  void dispose() {}

  Future<ApiResponse<News>> fetchList(
      {int currentPage, int perPage, String publishedAt}) async {
    ApiResponse<News> response = await getServiceLocator<NewsService>().fetchList(
        token: getServiceLocator<UserStore>().user.token,
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
    getServiceLocator<NewsStore>().setHighlightsNews(list);
    getServiceLocator<NewsStore>().setNews(news.news);
  }

  _updateWithFavorites(News news) async {
    List<String> favorites = await getSavedFavoriteNews();
    for (String favoriteTitle in favorites) {
      news.news.where((element) => element.title == favoriteTitle)
          .first.favorite = true;
    }
  }

  List<NewsItem> get highlightsNews => getServiceLocator<NewsStore>().highlightsNews;

  List<NewsItem> get news {
    bool isFavoriteSelected = getServiceLocator<FilterStore>().isJustFavorites;

    if (!isFavoriteSelected) return getServiceLocator<NewsStore>().news;

    List<NewsItem> list = List();

    for (NewsItem item in getServiceLocator<NewsStore>().news) {
      if (item.favorite?? false) list.add(item);
    }

    return list;
  }

  NewsItem get newSelected => getServiceLocator<NewsStore>().newSelected;

  void onNewItemPressed(item) {
    getServiceLocator<NewsStore>().setNewSelected(item);
    navigateTo(route: '/feed/new');
  }
}
