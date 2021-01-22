import 'package:shared_preferences/shared_preferences.dart';

final String tokenKey = "token";

saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(tokenKey, token);
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(tokenKey) == null ? ""
      : prefs.getString(tokenKey);

  return token;
}
