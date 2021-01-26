import 'package:flutter/material.dart';
import 'package:mesa_news/core/constant.dart';
import 'package:mesa_news/core/repository/database/shared.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/util/filter_util.dart';
import 'package:mesa_news/core/util/navigator_util.dart';
import 'package:mesa_news/core/viewmodel/base_viewmodel_contract.dart';
import 'package:mesa_news/locator.dart';

class FilterViewModel implements BaseViewModelContract {

  @override
  void dispose() {}

  String get dateSelected {
    if(getServiceLocator<FilterStore>().date == null) {
      getServiceLocator<FilterStore>().setDate("Todas");
    }
    return getServiceLocator<FilterStore>().date;
  }

  List<Widget> getDateItems() {
    List<Widget> list = List();
    for (int i = 0; i < dateOptions.length; i++) {
      list.add(FlatButton(
          onPressed: () => onItemMenuSelected(i),
          child: Text(dateOptions[i], style: TextStyle(color: colorLink))));
    }
    return list;
  }

  bool get isFavorite => getServiceLocator<FilterStore>().isJustFavorites;

  List<String> get getDateOptions => dateOptions;

  void onIsFavoriteChanged(value) {
    getServiceLocator<FilterStore>().setIsJustFavorites(value);
  }

  void onItemMenuSelected(int index, {bool isToPopDialog = true}) {
    if(isToPopDialog) navigatePop();

    saveDateFilter(getDateOptions[index]);
    getServiceLocator<FilterStore>().setDate(getDateOptions[index]);
  }
}
