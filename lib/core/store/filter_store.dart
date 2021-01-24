import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterBase with _$FilterStore;

abstract class _FilterBase with Store {

  @observable
  String date;

  @observable
  bool isJustFavorites = false;

  @action
  setDate(String dateFilter){
    this.date = dateFilter;
  }

  @action
  setIsJustFavorites(bool isFavorite) {
    this.isJustFavorites = isFavorite;
  }

  dispose() {
  }
}