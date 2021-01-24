import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/text_extension.dart';
import 'package:mesa_news/core/util/launcher_util.dart';
import 'package:mesa_news/ui/view/favorite_button_view.dart';
import 'package:mesa_news/ui/view/loading_view.dart';
import 'package:share/share.dart';

class FeedNewPage extends StatefulWidget {
  @override
  _FeedNewPageState createState() => _FeedNewPageState();
}

class _FeedNewPageState extends State<FeedNewPage> {

  NewsItem newsItemSelected;

  _appBar() {
    return AppBar(
      actions: [
        PopupMenuButton<int>(
          icon: Icon(Icons.more_horiz),
          onSelected: (result) {
            switch (result) {
              case 0:
                Share.share(newsItemSelected.url,
                    subject: newsItemSelected.title);
                break;
              case 1:
                if (newsItemSelected.url != null) {
                  launchInBrowser(newsItemSelected.url);
                }
                break;
              default:
                break;
            }
          },
          itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Compartilhar'),
            ),
            newsItemSelected.url != null ? const PopupMenuItem<int>(
              value: 1,
              child: Text('Acessar na web'),
            ) : null,
          ],
        )
      ],
      title: Column(
        children: [
          Text(
            newsItemSelected.title,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "mesanews.com.br",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    newsItemSelected = GetIt
        .I<NewsStore>()
        .newSelected;

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              child: CachedNetworkImage(imageUrl: newsItemSelected.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, url) => Center(child: LoadingView(text: "",),),
                errorWidget: (ctx, obj, stack) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60).paddingTo(bottom: 8),
                      Text("Imagem não encontrada")
                    ],);
                },),
            ),
            Row(
              children: [
                FavoriteButtonView(newsItemSelected, onPressed: () {
                  setState(() {});
                },),
                Spacer(),
                Text(
                  newsItemSelected.publishedAt,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            Text(newsItemSelected.title).h1().paddingTo(bottom: 12),
            Text(newsItemSelected.content)
          ],
        ),
      ).paddingAll(16),
    );
  }
}
