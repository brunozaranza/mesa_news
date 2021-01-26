import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/repository/database/database.dart';
import 'package:mesa_news/core/repository/database/database_contract.dart';
import 'package:mesa_news/core/repository/service/auth_service.dart';
import 'package:mesa_news/core/repository/service/news_service.dart';
import 'package:mesa_news/core/store/filter_store.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/viewmodel/auth_viewmodel.dart';
import 'package:mesa_news/core/viewmodel/news_viewmodel.dart';
import 'package:mesa_news/core/store/keyboard_store.dart';
import 'package:mesa_news/ui/app_config.dart';
import 'package:mesa_news/core/viewmodel/filter_viewmodel.dart';

final _serviceLocator = GetIt.instance;

T getServiceLocator<T>() {
  return _serviceLocator<T>();
}

void setupLocator() {

  _serviceLocator.registerLazySingleton<AppConfig>(() => AppConfig());

  // View Models
  _serviceLocator.registerLazySingleton<AuthViewModel>(() => AuthViewModel(),
      dispose: (vm) => vm.dispose());
  _serviceLocator.registerLazySingleton<NewsViewModel>(() => NewsViewModel(),
      dispose: (vm) => vm.dispose());
  _serviceLocator.registerLazySingleton<FilterViewModel>(() => FilterViewModel(),
      dispose: (vm) => vm.dispose());

  // Repository
  _serviceLocator.registerLazySingleton<DatabaseContract>(() => Database());
  _serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  _serviceLocator.registerLazySingleton<NewsService>(() => NewsService());

  // Stores - Mobx
  _serviceLocator.registerLazySingleton<UserStore>(() => UserStore(),
      dispose: (store) => store.dispose());
  _serviceLocator.registerLazySingleton<NewsStore>(() => NewsStore(),
      dispose: (store) => store.dispose());
  _serviceLocator.registerLazySingleton<FilterStore>(() => FilterStore(),
      dispose: (store) => store.dispose());
  _serviceLocator.registerLazySingleton<KeyboardStore>(() => KeyboardStore(),
      dispose: (store) => store.dispose());
}
