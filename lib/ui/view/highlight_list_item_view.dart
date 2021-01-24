import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/extension/string_extension.dart';
import 'package:mesa_news/core/extension/widget_extension.dart';
import 'package:mesa_news/core/extension/text_extension.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';
import 'package:mesa_news/ui/view/favorite_button_view.dart';
import 'package:mesa_news/ui/view/loading_view.dart';

class HighlightListItemView extends StatelessWidget {
  final NewsItem item;

  HighlightListItemView(this.item);

  @override
  Widget build(BuildContext context) {
    double sizeReference = MediaQuery.of(context).size.width / 1.2;

    INewsViewModel viewModel = GetIt.I<INewsViewModel>();

    return InkWell(
      onTap: () => viewModel.onNewItemPressed(item),
      child: Container(
        width: sizeReference,
        child: Card(
            child: Row(
          children: [
            Container(
                width: sizeReference / 2.3,
                height: sizeReference / 2.3,
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, url) => Center(
                    child: LoadingView(text: "", size: 20, stroke: 2,),
                  ),
                  errorWidget: (ctx, obj, stack) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 30)
                            .paddingTo(bottom: 8),
                        Text(
                          "Imagem não encontrada",
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  },
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: sizeReference / 4.5,
                    child: Text(item.title).h2(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FavoriteButtonView(item),
                        Text(
                          item.publishedAt.parseDateTimeAgo(),
                          style: TextStyle(fontSize: 13),
                        ).paddingTo(top: 10)
                      ],
                    ).paddingTo(top: 6),
                  )
                ],
              ).paddingAll(8),
            )
          ],
        )),
      ),
    );
  }
}
