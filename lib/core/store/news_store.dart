import 'package:mesa_news/core/model/news.dart';
import 'package:mobx/mobx.dart';

part 'news_store.g.dart';

class NewsStore = _NewsBase with _$NewsStore;

abstract class _NewsBase with Store {
  @observable
  List<NewsItem> highlightsNews;

  @observable
  List<NewsItem> news;

  NewsItem newSelected;

  onMarked(NewsItem item) {

    bool isFavorite = item.favorite == null? true : !item.favorite;

    highlightsNews.firstWhere((element) => element.title == item.title)
        .favorite = isFavorite;
    news.firstWhere((element) => element.title == item.title)
        .favorite = isFavorite;

    setHighlightsNews(highlightsNews.toList());
    setNews(news.toList());
  }

  setNewSelected(NewsItem newsItem){
    this.newSelected = newsItem;
  }

  @action
  setHighlightsNews(List<NewsItem> list) {
    this.highlightsNews = list;
  }

  @action
  setNews(List<NewsItem> list) {
    this.news = list;
  }

  dispose() {
    highlightsNews.clear();
    news.clear();
  }
}
