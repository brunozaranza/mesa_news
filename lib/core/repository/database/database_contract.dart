abstract class DatabaseContract {
  void saveString(String key, String value);
  void saveListString(String key, List<String> value);
  void saveStringToList(String key, String value);
  void saveStatus(String key, bool value);
  Future<String> getSavedString(String key);
  Future<List<String>> getSavedListString(String key);
  Future<bool> getStatus(String key);
  void deleteStringFromSavedList(String key, String value);
}