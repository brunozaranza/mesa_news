import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mesa_news/ui/app_config.dart';

void navigatePop<T>({T result}) {
  return GetIt.I<AppConfig>().navigatorKey
      .currentState.pop(result);
}

Future<T> navigateTo<T>({@required String route}){
  return GetIt.I<AppConfig>().navigatorKey
      .currentState.pushNamed(route);
}

Future<T> navigateReplaceAllTo<T>({@required String route}){
  return GetIt.I<AppConfig>().navigatorKey
      .currentState.pushNamedAndRemoveUntil(route, ModalRoute.withName('/'));
}