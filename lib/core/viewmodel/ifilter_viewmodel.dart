import 'package:flutter/material.dart';
import 'package:mesa_news/core/viewmodel/ibase_viewmodel.dart';

abstract class IFilterViewModel extends IBaseViewModel {
  String get dateSelected;

  bool get isFavorite;

  List<String> get getDateOptions;

  void onIsFavoriteChanged(bool value);

  void onItemMenuSelected(int index, {bool isToPopDialog});

  List<Widget> getDateItems();


}