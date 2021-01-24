import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/model/news.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/store/news_store.dart';

class FavoriteButtonView extends StatelessWidget {
  final NewsItem item;
  final Function() onPressed;

  FavoriteButtonView(this.item, {this.onPressed});

  _onFavoriteButtonPressed(NewsItem item) {
    GetIt.I<NewsStore>().onMarked(item);
    if (!item.favorite) {
      saveFavoriteNew(item.title);
    }
    else {
      deleteFavoriteNew(item.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          item.favorite == true ? Icons.bookmark : Icons.bookmark_outline,
          size: 30,
        ),
        onPressed: () {
          _onFavoriteButtonPressed(item);
          if(onPressed != null) onPressed();
        });
  }
}
