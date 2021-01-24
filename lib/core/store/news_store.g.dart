// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsStore on _NewsBase, Store {
  final _$highlightsNewsAtom = Atom(name: '_NewsBase.highlightsNews');

  @override
  List<NewsItem> get highlightsNews {
    _$highlightsNewsAtom.reportRead();
    return super.highlightsNews;
  }

  @override
  set highlightsNews(List<NewsItem> value) {
    _$highlightsNewsAtom.reportWrite(value, super.highlightsNews, () {
      super.highlightsNews = value;
    });
  }

  final _$newsAtom = Atom(name: '_NewsBase.news');

  @override
  List<NewsItem> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(List<NewsItem> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$_NewsBaseActionController = ActionController(name: '_NewsBase');

  @override
  dynamic setHighlightsNews(List<NewsItem> list) {
    final _$actionInfo = _$_NewsBaseActionController.startAction(
        name: '_NewsBase.setHighlightsNews');
    try {
      return super.setHighlightsNews(list);
    } finally {
      _$_NewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNews(List<NewsItem> list) {
    final _$actionInfo =
        _$_NewsBaseActionController.startAction(name: '_NewsBase.setNews');
    try {
      return super.setNews(list);
    } finally {
      _$_NewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
highlightsNews: ${highlightsNews},
news: ${news}
    ''';
  }
}
