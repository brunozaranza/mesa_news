import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/util/filter_util.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/ifilter_viewmodel.dart';

class FilterViewModel implements IFilterViewModel {
  @override
  String get dateSelected => GetIt.I<FilterStore>().date;

  @override
  List<Widget> getDateItems() {
    List<Widget> list = List();
    for (int i = 0; i < dateOptions.length; i++) {
      list.add(FlatButton(
          onPressed: () => onItemMenuSelected(i),
          child: Text(dateOptions[i], style: TextStyle(color: colorLink))));
    }
    return list;
  }

  @override
  bool get isFavorite => GetIt.I<FilterStore>().isJustFavorites;

  @override
  List<String> get getDateOptions => dateOptions;

  @override
  void onIsFavoriteChanged(value) {
    GetIt.I<FilterStore>().setIsJustFavorites(value);
  }

  @override
  void onItemMenuSelected(int index, {bool isToPopDialog = true}) {
    if(isToPopDialog) navigatePop();

    saveDateFilter(getDateOptions[index]);
    GetIt.I<FilterStore>().setDate(getDateOptions[index]);
  }

  @override
  void dispose() {}
}
