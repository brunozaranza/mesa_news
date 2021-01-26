import 'package:mesa_news/core/repository/database/database_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database implements DatabaseContract {

  SharedPreferences _shared;

  Future<SharedPreferences> getSharedInstance() async {
    if (_shared == null) _shared = await SharedPreferences.getInstance();
    return _shared;
  }

  @override
  void saveListString(String key, List<String> value) async {
    (await getSharedInstance()).setStringList(key, value);
  }

  @override
  void saveStatus(String key, bool value) async {
    (await getSharedInstance()).setBool(key, value);
  }

  @override
  void saveString(String key, String value) async {
    (await getSharedInstance()).setString(key, value);
  }

  @override
  void saveStringToList(String key, String value) async {
    List<String> list = await getSavedListString(key);
    list.add(value);
    (await getSharedInstance()).setStringList(key, list);
  }

  @override
  Future<List<String>> getSavedListString(String key) async {
    return (await getSharedInstance()).getStringList(key)?? List<String>();
  }

  @override
  Future<String> getSavedString(String key) async {
    return (await getSharedInstance()).getString(key)?? "";
  }

  @override
  void deleteStringFromSavedList(String key, String value) async {
    List<String> list = await getSavedListString(key);
    list.remove(list.where((element) => element == value).first);
    saveListString(key, list);
  }

  @override
  Future<bool> getStatus(String key) async {
    return (await getSharedInstance()).getBool(key);
  }
}
