import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/ui/view/highlights_list_view.dart';
import 'package:mesa_news/ui/view/news_list_view.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  _appBar() {
    return AppBar(
      title: Text("Mesa News"),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              navigateTo(route: "/filter").then((_) {
                var store = GetIt.I<NewsStore>();
                store.setNews(store.news.toList());
              });
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Observer(builder: (_) {
          return Column(
            children: [
              GetIt.I<FilterStore>().isJustFavorites ? Container() : HighlightsListView(),
              SizedBox(height: 16),
              NewsListView()
            ],
          );
        }),
      ),
    );
  }
}
