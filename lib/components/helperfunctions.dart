import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceMessagePosition = "MESSAGEPOSITION";

  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  /// fetching data from sharedpreference

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

  ///THIS FUNCTION HELPS TO SET THE MESSAGE POSITION


  static Future<bool> setMessagePosition(int value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value == null){
      return await preferences.setInt(sharedPreferenceMessagePosition,0);
    }else{
      return await preferences.setInt(sharedPreferenceMessagePosition,value);
    }

  }
  static Future<int> getMessagePositionSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(sharedPreferenceMessagePosition);
  }

  static getVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    var alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  static setVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', true);
  }


}