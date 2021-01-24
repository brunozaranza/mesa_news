import 'package:shared_preferences/shared_preferences.dart';

final String tokenKey = "token";
final String favoriteKey = "favoriteList";
final String dateKey = "dateFilter";

void saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(tokenKey, token);
}

Future<String> getSavedToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(tokenKey) == null ? ""
      : prefs.getString(tokenKey);

  return token;
}

void saveFavoriteNew(String favoriteNew) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = await getSavedFavoriteNews();
  list.add(favoriteNew);
  prefs.setStringList(favoriteKey, list);
}

void deleteFavoriteNew(String favoriteNew) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = await getSavedFavoriteNews();
  list.remove(list.where((element) => element == favoriteNew).first);
  prefs.setStringList(favoriteKey, list);
}

Future<List<String>> getSavedFavoriteNews() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = prefs.getStringList(favoriteKey) == null ? List<String>()
      : prefs.getStringList(favoriteKey);

  return list;
}

void saveDateFilter(String date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(dateKey, date);
}

Future<String> getSavedDateFilter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String date = prefs.getString(dateKey) == null ? "Todas"
      : prefs.getString(dateKey);

  return date;
}