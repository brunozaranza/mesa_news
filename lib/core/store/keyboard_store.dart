import 'package:mobx/mobx.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

part 'keyboard_store.g.dart';

class KeyboardStore = _KeyboardBase with _$KeyboardStore;

abstract class _KeyboardBase with Store {

  @observable
  bool keyboardState;

  int keyboardVisibilitySubscriberId;

  KeyboardVisibilityNotification keyboardVisibility = KeyboardVisibilityNotification();

  setKeyboardVisibilitySubscriberId(int id) {
    this.keyboardVisibilitySubscriberId = id;
  }

  @action
  setKeyboardState(bool state) {
    this.keyboardState = state;
  }

  dispose() {
    keyboardVisibility.dispose();
  }
}