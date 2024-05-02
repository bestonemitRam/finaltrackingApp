import 'dart:ffi';

import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/data/source/network/model/login/Loginresponse.dart';
import 'package:bmitserp/data/source/network/model/login/User.dart';
import 'package:bmitserp/data/source/network/model/login/Login.dart';
import 'package:bmitserp/main.dart';
import 'package:bmitserp/model/check_auth_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  Future<bool> saveUser(Result data) async {
    // Obtain shared preferences.
    User user = data.user!;
    print("fgfgkjhfjgkjhfjghkf  ${user.fullName}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Apphelper.USER_TOKEN, data.tokens);
    await prefs.setInt(Apphelper.USER_ID, user.id!);
    await prefs.setString(Apphelper.USER_AVATAR, user.avatar);
    await prefs.setString(Apphelper.USER_EMAIL, user.mail);
    await prefs.setString(Apphelper.USER_NAME, user.fullName);
    await prefs.setString(Apphelper.USER_EMP_CODE, user.employeeCode);
    await prefs.setString(Apphelper.USER_CONTACT, user.contact);
    await prefs.setString(Apphelper.USER_DOB, user.dob);
    await prefs.setString(Apphelper.USER_GENDAR, user.gender);
    Apphelper.USER_DOB = user.dob!;
    Apphelper.USER_GENDAR = user.gender!;
    Apphelper.USER_CONTACT = user.contact!;
    Apphelper.USER_AVATAR = user.avatar;
    Apphelper.USER_NAME = user.fullName!;
    print("kjfdgjk  ${user.fullName!}");
    notifyListeners();
    return true;
  }

  Future<bool> checkAuth(
      UserDatas data, String active_status, totalWorkingHours) async {
    // Obtain shared preferences.
    print("dfgkjhdg ${active_status}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Apphelper.USER_TOKEN, data.userToken!);
    await prefs.setInt(Apphelper.USER_ID, data.id!);
    await prefs.setString(
        Apphelper.USER_AVATAR, data.avatar != null ? data.avatar : '');
    await prefs.setString(Apphelper.USER_EMAIL, data.mail!);
    await prefs.setString(Apphelper.USER_NAME, data.fullName!);
    // await prefs.setString(Apphelper.USER_EMP_CODE, data.employeeCode);
    await prefs.setString(Apphelper.USER_CONTACT, data.contact!);
    await prefs.setString(Apphelper.USER_DOB, data.dob!);
    await prefs.setString(Apphelper.USER_GENDAR, data.gender!);
    await prefs.setString(Apphelper.CHECK_STATUS, active_status!);

    Apphelper.USER_DOB = data.dob!;
    Apphelper.USER_GENDAR = data.gender!;
    Apphelper.USER_CONTACT = data.contact!;
    Apphelper.USER_AVATAR = data.avatar != null ? data.avatar : '';
    Apphelper.USER_NAME = data.fullName!;
    Apphelper.USER_EMAIL = data.mail!;
    Apphelper.CHECK_STATUS = active_status;
    Apphelper.totalWorkingHours = totalWorkingHours;

    // MyApp.userName=
    print("kjfdgjk  ${data.fullName!}   $totalWorkingHours");

    notifyListeners();
    return true;
  }

  // Future<bool> saveUser(String tokens, int userId, String userAvatar,
  //     String userEmail, String userName, String name) async
  //      {
  //   // Obtain shared preferences.

  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(Apphelper.USER_TOKEN, tokens);
  //   await prefs.setInt(Apphelper.USER_ID, userId);
  //   await prefs.setString(Apphelper.USER_AVATAR, userAvatar);
  //   await prefs.setString(Apphelper.USER_EMAIL, userEmail);
  //   await prefs.setString(Apphelper.USER_NAME, userName);
  //   await prefs.setString(Apphelper.USER_FULLNAME, name);
  //   notifyListeners();
  //   return true;
  // }

  /// Save_BASIC_USER_DATA
  void saveBasicUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Apphelper.USER_ID, user.id!);
    await prefs.setString(Apphelper.USER_AVATAR, user.avatar);
    await prefs.setString(Apphelper.USER_EMAIL, user.mail);
    await prefs.setString(Apphelper.USER_NAME, user.fullName);
    await prefs.setString(Apphelper.USER_EMP_CODE, user.employeeCode);
    notifyListeners();
  }

  /// CLEAR_PREFERENCE_DATA
  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Apphelper.USER_ID, 0);
    await prefs.setString(Apphelper.USER_TOKEN, '');
    await prefs.setString(Apphelper.USER_AVATAR, '');
    await prefs.setString(Apphelper.USER_EMAIL, '');
    await prefs.setString(Apphelper.USER_NAME, '');
    await prefs.setBool(Apphelper.USER_AUTH, false);
    await prefs.setBool(Apphelper.APP_IN_ENGLISH, true);
    notifyListeners();
  }

  /// SAVE_USER_AUTHENTICATION
  void saveUserAuth(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Apphelper.USER_AUTH, value);
  }

  /// SAVE_APP_IN_ENGLISH
  void saveAppEng(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Apphelper.APP_IN_ENGLISH, value);
  }

  /// SAVE_APP_IN_ENGLISH
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    print("lknvbvbjnn  ${Apphelper.USER_NAME}");
    return User(
      id: prefs.getInt(Apphelper.USER_ID) ?? 0,
      employeeCode: prefs.getString(Apphelper.USER_EMP_CODE) ?? "",
      mail: prefs.getString(Apphelper.USER_EMAIL) ?? "",
      fullName: prefs.getString(Apphelper.USER_NAME) ?? "",
      avatar: prefs.getString(Apphelper.USER_AVATAR) ?? "",
    );
  }

  /// GET_TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(Apphelper.USER_TOKEN) ?? '';
  }

  ///USER_ID
  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Apphelper.USER_ID) ?? 0;
  }

  /// GET_USER_AUTH
  Future<bool> getUserAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Apphelper.USER_AUTH) ?? false;
  }

  /// GET_USER_NAME
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.USER_NAME = prefs.getString(Apphelper.USER_NAME) ?? "";
    return prefs.getString(Apphelper.USER_NAME) ?? "";
  }

  /// GET_EMAIL
  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.USER_EMAIL = prefs.getString(Apphelper.USER_EMAIL) ?? "";
    return prefs.getString(Apphelper.USER_EMAIL) ?? "";
  }

  /// GET_AVATAR
  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.USER_AVATAR = prefs.getString(Apphelper.USER_AVATAR) ?? "";
    return prefs.getString(Apphelper.USER_AVATAR) ?? "";
  }

  /// GET_FULL_NAME
  Future<String> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    print("kjfhkjgkjfgh  ${prefs.getString(Apphelper.USER_NAME) ?? ""}");
    Apphelper.USER_NAME = prefs.getString(Apphelper.USER_NAME) ?? "";
    return prefs.getString(Apphelper.USER_NAME) ?? "";
  }

  Future<bool> getEnglishDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Apphelper.APP_IN_ENGLISH) ?? true;
  }
}
