//ใช้คำสั่งด้านบนเพิื่อยกเลิก nuul safty
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyAddress = 'address';
  static const _keyCountry = 'country';
  static const _keyAvartar = 'avartar';
  static const _keyId = 'id';
  static const _keyRoles = 'roles';
  static const _keyUid = 'uid';

  static Future<bool> setUid(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyUid, value);
  }

// Read Data
  static Future<String?> getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyUid);
  }

  static Future<bool> setUsername(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyUsername, value!);
  }

// Read Data
  static Future<String?> getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyUsername);
  }

  // // Read Data
  // static Future<String?> getUsername() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getString(_keyUsername);
  // }

  static Future<bool> setEmail(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyEmail, value!);
  }

// Read Data
  static Future<String?> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyEmail);
  }

  static Future<bool> setAddress(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyAddress, value!);
  }

// Read Data
  static Future<String?> getAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyAddress);
  }

  static Future<bool> setCountry(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyCountry, value!);
  }

// Read Data
  static Future<String?> getCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyCountry);
  }

  static Future<bool> setAvartar(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyAvartar, value!);
  }

// Read Data
  static Future<String?> getAvartar() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyAvartar);
  }

  static Future<bool> setId(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_keyId, value);
  }

// Read Data
  static Future<String?> getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_keyId);
  }

  static Future<bool> setRoles(List<String> value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setStringList(_keyRoles, value!);
  }

// Read Data
  static Future<List<String>?> getRoles() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(_keyRoles);
  }
}

// class UserSharedPreferences {
//   static SharedPreferences _preferences = ;

//   static const _keyUsername = 'username';
//   static const _keyEmail = 'email';
//   static const _keyAddress = 'address';
//   static const _keyCountry = 'country';
//   static const _keyAvartar = 'avartar';
//   static const _keyId = 'id';
//   static const _keyRoles = 'roles';

//   static const _keyList = 'lists';
//   static const _keydate = 'date';
//   static const _keyloggedin = 'loggedin';
//   static Future init() async {
    
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setUsername(String username) async =>
//       await _preferences.setString(_keyUsername, username);
//   static String getUsername() => _preferences.getString(_keyUsername);

//   static Future setEmail(String email) async =>
//       await _preferences.setString(_keyEmail, email);
//   static String getEmail() => _preferences.getString(_keyEmail);

//   static Future setAddress(String address) async =>
//       await _preferences.setString(_keyAddress, address);
//   static String getAddress() => _preferences.getString(_keyAddress);

//   static Future setCountry(String country) async =>
//       await _preferences.setString(_keyCountry, country);
//   static String getCountry() => _preferences.getString(_keyCountry);

//   static Future setAvartar(String avartar) async =>
//       await _preferences.setString(_keyAvartar, avartar);
//   static String getAvartar() => _preferences.getString(_keyAvartar);

//   static Future setId(int id) async => await _preferences.setInt(_keyId, id);
//   static int getId() => _preferences.getInt(_keyId);

//   static Future setLoggedin(bool loggedin) async =>
//       await _preferences.setBool(_keyloggedin, loggedin);
//   static bool getLoggedin() => _preferences.getBool(_keyloggedin);

//   static Future setRoles(List<String> roles) async {
//     await _preferences.setStringList(_keyRoles, roles);
//   }

//   static List<String> getRoles() => _preferences.getStringList(_keyRoles);

//   static Future setdate(DateTime date) async {
//     final dates = date.toIso8601String();

//     return await _preferences.setString(_keydate, dates);
//   }

//   static DateTime getdate() {
//     final dates = _preferences.getString(_keydate);
//     return dates == null ? null : DateTime.tryParse(dates);
//   }
// }
