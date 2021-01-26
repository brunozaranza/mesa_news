import 'package:flutter/material.dart';
import 'package:mesa_news/locator.dart';
import 'package:mesa_news/ui/app_config.dart';

void navigatePop<T>({T result}) {
  return getServiceLocator<AppConfig>().navigatorKey
      .currentState.pop(result);
}

Future<T> navigateTo<T>({@required String route}){
  return getServiceLocator<AppConfig>().navigatorKey
      .currentState.pushNamed(route);
}

Future<T> navigateReplaceAllTo<T>({@required String route}){
  return getServiceLocator<AppConfig>().navigatorKey
      .currentState.pushNamedAndRemoveUntil(route, ModalRoute.withName('/'));
}