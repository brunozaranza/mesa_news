import 'package:mesa_news/core/store/keyboard_store.dart';
import 'package:mesa_news/locator.dart';

void setupKeyboardBehavior() {
  KeyboardStore store = getServiceLocator<KeyboardStore>();

  store.setKeyboardState(store.keyboardVisibility.isKeyboardVisible);
  store.setKeyboardVisibilitySubscriberId(
      store.keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          store.setKeyboardState(visible);
        },
      ));
}