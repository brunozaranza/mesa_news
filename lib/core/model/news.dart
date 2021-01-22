import 'package:mesa_news/core/model/api_pagination.dart';

class News {
  List<NewsItem> news;
  ApiPagination pagination;

  News({this.news, this.pagination});

  News.fromJson(Map<String, dynamic> map) {
    if(map.containsKey('pagination')) {
      this.pagination = ApiPagination.fromJson(map['pagination']);
    }
    var e = map['data'] as List;
    this.news = e.map((i) => NewsItem.fromJson(i)).cast<NewsItem>().toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news'] = this.news;

    return data;
  }
}

class NewsItem {
  String title;
  String description;
  String content;
  String author;
  String publishedAt;
  bool highlight;
  String url;
  String imageUrl;

  NewsItem({
    this.title,
    this.description,
    this.content,
    this.author,
    this.publishedAt,
    this.highlight,
    this.url,
    this.imageUrl,
  });

  NewsItem.fromJson(Map<String, dynamic> map) {
    this.title = map["title"];
    this.description = map["description"];
    this.content = map["content"];
    this.author = map["author"];
    this.publishedAt = map["published_at"];
    this.highlight = map["highlight"];
    this.url = map["url"];
    this.imageUrl = map["image_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['content'] = this.content;
    data['author'] = this.author;
    data['published_at'] = this.publishedAt;
    data['highlight'] = this.highlight;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;

    return data;
  }
}


