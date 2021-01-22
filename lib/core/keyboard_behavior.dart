import 'package:mesa_news/core/store/keyboard_store.dart';
import 'package:get_it/get_it.dart';

void setupKeyboardBehavior() {
  KeyboardStore store = GetIt.I<KeyboardStore>();

  store.setKeyboardState(store.keyboardVisibility.isKeyboardVisible);
  store.setKeyboardVisibilitySubscriberId(
      store.keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          store.setKeyboardState(visible);
        },
      ));
}