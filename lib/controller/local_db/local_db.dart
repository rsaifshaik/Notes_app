
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static String loginKey = 'login_key';
  static String signupKey = 'signup_key';
  static String userIdKey = 'userId';

  static void setIsLogin(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await sharedPreferences.setBool(loginKey, isLogin);
  }

  static void setUserId(String uid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await sharedPreferences.setString(userIdKey, uid);
  }

  static Future<bool> getIsLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool(loginKey);
    return isLogin ?? false;
  }

  static Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString(userIdKey);
    return userId;

  }

  static void setIsSignup(bool isSignup) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await sharedPreferences.setBool(signupKey, isSignup);
  }

  static Future<bool> getIsSignup() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isSignup = sharedPreferences.getBool(signupKey);
    return isSignup ?? false;
  }
}