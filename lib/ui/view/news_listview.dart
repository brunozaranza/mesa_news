import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  INewsViewModel _viewModel;

  _onSaveButtonPressed(NewsItem item) {
    setState(() => item.highlight = !item.highlight);
  }

  _listView() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _viewModel.news.length,
        itemBuilder: (_, index) {
          NewsItem item = _viewModel.news.elementAt(index);
          return _listItem(item);
        });
  }

  _listItem(NewsItem item) {
    return InkWell(
      onTap: () => print("Abrir notícia ${item.title}"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (ctx, obj, stack) {
                return Center(
                    child: Text(
                  'Imagem não encontrada',
                  textAlign: TextAlign.center,
                ));
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    item.highlight == true
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    size: 30,
                  ),
                  onPressed: () {
                    _onSaveButtonPressed(item);
                  }),
              Spacer(),
              Text(
                item.publishedAt.parseDateTimeAgo(),
                style: TextStyle(fontSize: 13),
              ).spaceTo(right: 16),
            ],
          ).spaceTo(bottom: 8),
          Text(
            item.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ).spaceTo(bottom: 16),
          Text(item.description).spaceTo(bottom: 16),
          Divider(color: Colors.grey.shade700,)
        ],
      ).paddingAll(16),
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = GetIt.I<INewsViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Últimas notícias",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ).spaceTo(left: 16, bottom: 10, top: 16),
        _viewModel.news == null
            ? FutureBuilder(
                future: _viewModel.fetchList(),
                builder: (_, AsyncSnapshot<ApiResponse<News>> snap) {
                  if (!snap.hasData) return LoadingView();

                  GetIt.I<NewsStore>().setNews(snap.data.result.news);

                  return _listView();
                })
            : _listView(),
      ],
    );
  }
}
