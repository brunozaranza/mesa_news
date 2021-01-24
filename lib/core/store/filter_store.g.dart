// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterBase, Store {
  final _$dateAtom = Atom(name: '_FilterBase.date');

  @override
  String get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$isJustFavoritesAtom = Atom(name: '_FilterBase.isJustFavorites');

  @override
  bool get isJustFavorites {
    _$isJustFavoritesAtom.reportRead();
    return super.isJustFavorites;
  }

  @override
  set isJustFavorites(bool value) {
    _$isJustFavoritesAtom.reportWrite(value, super.isJustFavorites, () {
      super.isJustFavorites = value;
    });
  }

  final _$_FilterBaseActionController = ActionController(name: '_FilterBase');

  @override
  dynamic setDate(String dateFilter) {
    final _$actionInfo =
        _$_FilterBaseActionController.startAction(name: '_FilterBase.setDate');
    try {
      return super.setDate(dateFilter);
    } finally {
      _$_FilterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsJustFavorites(bool isFavorite) {
    final _$actionInfo = _$_FilterBaseActionController.startAction(
        name: '_FilterBase.setIsJustFavorites');
    try {
      return super.setIsJustFavorites(isFavorite);
    } finally {
      _$_FilterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
date: ${date},
isJustFavorites: ${isJustFavorites}
    ''';
  }
}
