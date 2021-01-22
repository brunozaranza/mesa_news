// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$KeyboardStore on _KeyboardBase, Store {
  final _$keyboardStateAtom = Atom(name: '_KeyboardBase.keyboardState');

  @override
  bool get keyboardState {
    _$keyboardStateAtom.reportRead();
    return super.keyboardState;
  }

  @override
  set keyboardState(bool value) {
    _$keyboardStateAtom.reportWrite(value, super.keyboardState, () {
      super.keyboardState = value;
    });
  }

  final _$_KeyboardBaseActionController =
      ActionController(name: '_KeyboardBase');

  @override
  dynamic setKeyboardState(bool state) {
    final _$actionInfo = _$_KeyboardBaseActionController.startAction(
        name: '_KeyboardBase.setKeyboardState');
    try {
      return super.setKeyboardState(state);
    } finally {
      _$_KeyboardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
keyboardState: ${keyboardState}
    ''';
  }
}
