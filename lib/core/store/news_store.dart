import 'package:mesa_news/core/model/news.dart';
import 'package:mobx/mobx.dart';

part 'news_store.g.dart';

class NewsStore = _NewsBase with _$NewsStore;

abstract class _NewsBase with Store {

  List<NewsItem> highlightsNews;
  List<NewsItem> news;

  setHighlightsNews(List<NewsItem> highlightsList) {
    this.highlightsNews = highlightsList;
  }

  setNews(List<NewsItem> list) {
    this.news = list;
  }
}