import 'package:mesa_news/core/model/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserBase with _$UserStore;

abstract class _UserBase with Store {

  User user;

  setUser(User _user) {
    this.user = _user;
  }

  dispose() {
    user = null;
  }
}