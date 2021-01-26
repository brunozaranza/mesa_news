import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/viewmodel/news_viewmodel.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/view/favorite_button_view.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/text_extension.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class NewsListItemView extends StatelessWidget {
  final NewsItem item;

  NewsListItemView(this.item);

  @override
  Widget build(BuildContext context) {

    NewsViewModel viewModel = getServiceLocator<NewsViewModel>();

    return InkWell(
      onTap: () => viewModel.onNewItemPressed(item),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 1.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, url) => Center(
                  child: LoadingView(text: ""),
                ),
                errorWidget: (ctx, obj, stack) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60).paddingTo(bottom: 8),
                      Text("Imagem não encontrada")
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                FavoriteButtonView(item),
                Spacer(),
                Text(
                  item.publishedAt.parseDateTimeAgo(),
                  style: TextStyle(fontSize: 13),
                ).paddingTo(right: 16),
              ],
            ).paddingTo(bottom: 8),
            Text(
              item.title,
            ).h2().paddingTo(bottom: 16),
            Text(item.description).paddingTo(bottom: 16),
            Divider(
              color: Colors.grey.shade700,
            )
          ],
        ).paddingAll(16),
      ),
    );
  }
}
