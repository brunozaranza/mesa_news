import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';
import 'package:mesa_news/ui/view/highlights_listview.dart';
import 'package:mesa_news/ui/view/news_listview.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  INewsViewModel _viewModel;

  _appBar() {
    return AppBar(
      title: Text("Mesa News"),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.filter_list), onPressed: () => print("filter"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = GetIt.I<INewsViewModel>();

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            HighlightsListView(),
            SizedBox(height: 16),
            NewsListView()
          ],
        ),
      ),
    );
  }
}
