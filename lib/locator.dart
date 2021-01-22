import 'package:get_it/get_it.dart';
import 'package:mesa_news/core/repository/service/auth_service.dart';
import 'package:mesa_news/core/repository/service/iauth_service.dart';
import 'package:mesa_news/core/repository/service/inews_service.dart';
import 'package:mesa_news/core/repository/service/news_service.dart';
import 'package:mesa_news/core/store/news_store.dart';
import 'package:mesa_news/core/store/user_store.dart';
import 'package:mesa_news/core/viewmodel/auth_viewmodel.dart';
import 'package:mesa_news/core/viewmodel/iauth_viewmodel.dart';
import 'package:mesa_news/core/viewmodel/inews_viewmodel.dart';
import 'package:mesa_news/core/viewmodel/news_viewmodel.dart';
import 'package:mesa_news/ui/app_config.dart';
import 'package:mesa_news/core/store/keyboard_store.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AppConfig>(() => AppConfig());

  // View Models
  getIt.registerLazySingleton<IAuthViewModel>(() => AuthViewModel());
  getIt.registerLazySingleton<INewsViewModel>(() => NewsViewModel());

  // Stores - Mobx
  getIt.registerLazySingleton<UserStore>(() => UserStore());
  getIt.registerLazySingleton<NewsStore>(() => NewsStore());
  getIt.registerLazySingleton<KeyboardStore>(() => KeyboardStore());

  // Repository
  getIt.registerLazySingleton<IAuthService>(() => AuthService());
  getIt.registerLazySingleton<INewsService>(() => NewsService());
}