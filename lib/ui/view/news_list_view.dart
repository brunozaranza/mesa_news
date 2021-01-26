import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/text_extension.dart';
import 'package:mesa_news/core/viewmodel/news_viewmodel.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/view/loading_view.dart';
import 'package:mesa_news/ui/view/news_list_item_view.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {

  NewsViewModel _viewModel;

  _listView() {
    return _viewModel.news.length == 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getServiceLocator<FilterStore>().isJustFavorites
                    ? "Você não salvou nenhuma notícia ainda. :("
                    : "Não há notícias para exibir"),
              ],
            ))
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _viewModel.news.length,
            itemBuilder: (_, index) {
              NewsItem item = _viewModel.news.elementAt(index);

              return NewsListItemView(item);
            });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = getServiceLocator<NewsViewModel>();

    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            getServiceLocator<FilterStore>().isJustFavorites
                ? "Minhas favoritas"
                : "Últimas notícias",
          ).h1().paddingTo(left: 16, bottom: 10, top: 16),
          _viewModel.news == null
              ? FutureBuilder(
                  future: _viewModel.fetchList(),
                  builder: (_, AsyncSnapshot<ApiResponse<News>> snap) {
                    if (!snap.hasData) return LoadingView();
                    return _listView();
                  })
              : _listView(),
        ],
      );
    });
  }
}
