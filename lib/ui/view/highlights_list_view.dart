import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/text_extension.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/viewmodel/news_viewmodel.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/view/highlight_list_item_view.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class HighlightsListView extends StatefulWidget {
  @override
  _HighlightsListViewState createState() => _HighlightsListViewState();
}

class _HighlightsListViewState extends State<HighlightsListView> {

  NewsViewModel _viewModel;

  _listView() {
    double sizeReference = MediaQuery.of(context).size.width / 1.2;

    return Observer(builder: (_) {
      return Container(
        height: sizeReference / 2.3,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _viewModel.highlightsNews.length,
            itemBuilder: (_, index) {
              NewsItem item = _viewModel.highlightsNews.elementAt(index);
              return HighlightListItemView(item);
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = getServiceLocator<NewsViewModel>();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Destaques",
          ).h1().paddingTo(left: 16, bottom: 10, top: 16),
          _viewModel.highlightsNews == null ? FutureBuilder(
              future: _viewModel.fetchList(),
              builder: (_, AsyncSnapshot<ApiResponse<News>> snap) {
                if (!snap.hasData) return LoadingView();
                return _listView();
              }) : _listView(),
        ],
      );
  }
}
