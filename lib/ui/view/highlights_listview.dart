import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:mesa_news/core/model/api_response.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class HighlightsListView extends StatefulWidget {
  @override
  _HighlightsListViewState createState() => _HighlightsListViewState();
}

class _HighlightsListViewState extends State<HighlightsListView> {
  INewsViewModel _viewModel;

  _onSaveButtonPressed(NewsItem item) {
    setState(() => item.highlight = !item.highlight);
  }

  _listView() {
    double sizeReference = MediaQuery.of(context).size.width / 1.2;

    return Container(
      height: sizeReference / 2.3,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _viewModel.highlightsNews.length,
          itemBuilder: (_, index) {
            NewsItem item = _viewModel.highlightsNews.elementAt(index);
            return _listItem(item);
          }),
    );
  }

  _listItem(NewsItem item) {
    double sizeReference = MediaQuery.of(context).size.width / 1.2;

    return InkWell(
      onTap: () => print("Abrir notícia ${item.title}"),
      child: Container(
        width: sizeReference,
        child: Card(
            child: Row(
              children: [
                Container(
                    width: sizeReference / 2.3,
                    height: sizeReference / 2.3,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, obj, stack) {
                        return Center(child: Text('Imagem não encontrada', textAlign: TextAlign.center,));
                      },
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: sizeReference / 4.5,
                        child: Text(
                          item.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
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
                            Text(
                              item.publishedAt.parseDateTimeAgo(),
                              style: TextStyle(fontSize: 13),
                            ).spaceTo(top: 10)
                          ],
                        ).spaceTo(top: 6),
                      )
                    ],
                  ).paddingAll(8),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = GetIt.I<INewsViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Destaques",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ).spaceTo(left: 16, bottom: 10, top: 16),
        _viewModel.highlightsNews == null ? FutureBuilder(
            future: _viewModel.fetchHighlightsList(),
            builder: (_, AsyncSnapshot<ApiResponse<News>> snap) {
              if (!snap.hasData) return LoadingView();

              GetIt.I<NewsStore>().setHighlightsNews(snap.data.result.news);

              return _listView();
            }) : _listView(),
      ],
    );
  }
}
