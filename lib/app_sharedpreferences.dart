
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  //----------------------------------------------------------------------------

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //----------------------------------------------------------------------------

  static Future<String> getProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_name');
  }

  static Future<void> setProfileName(String profileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('profile_name', profileName);
  }

  //----------------------------------------------------------------------------

  static Future<String> getFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('first_name');
  }

  static Future<void> setFirstName(String firstName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('first_name', firstName);
  }

  //----------------------------------------------------------------------------

  static Future<String> getLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_name');
  }

  static Future<void> setLastName(String lastName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('last_name', lastName);
  }
  //----------------------------------------------------------------------------

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_email');
  }

  static Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('profile_email', email);
  }

  //----------------------------------------------------------------------------

  static Future<String> getProfilePhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_photo');
  }

  static Future<void> setProfilePhoto(String photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('profile_photo', photo);
  }

}
