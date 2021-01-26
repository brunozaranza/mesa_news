import 'package:mesa_news/core/repository/database/database_contract.dart';
import 'package:mesa_news/core/repository/database/database_keys.dart';
import 'package:mesa_news/locator.dart';

void saveToken(String token) {
  getServiceLocator<DatabaseContract>()
      .saveString(DATABASE_KEYS.token.toString(), token);
}

void saveFavoriteNew(String favoriteNew)  {
  getServiceLocator<DatabaseContract>()
      .saveStringToList(DATABASE_KEYS.favorite.toString(), favoriteNew);
}

void deleteFavoriteNew(String favoriteNew) {
  getServiceLocator<DatabaseContract>()
      .deleteStringFromSavedList(DATABASE_KEYS.favorite.toString(), favoriteNew);
}

void saveDateFilter(String date) {
  getServiceLocator<DatabaseContract>()
      .saveString(DATABASE_KEYS.date.toString(), date);
}

Future<String> getSavedToken() {
  return getServiceLocator<DatabaseContract>()
      .getSavedString(DATABASE_KEYS.token.toString());
}

Future<List<String>> getSavedFavoriteNews() {
  return getServiceLocator<DatabaseContract>()
      .getSavedListString(DATABASE_KEYS.favorite.toString());
}

Future<String> getSavedDateFilter() async {
  return await getServiceLocator<DatabaseContract>()
      .getSavedString(DATABASE_KEYS.date.toString()) ?? "Todas";
}