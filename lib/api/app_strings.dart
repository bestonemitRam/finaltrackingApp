import 'package:flutter/material.dart';
class Apphelper {
  
  static String USER_DOB = 'USER_DOB';
  static String USER_CONTACT = 'USER_CONTACT';
  static String USER_GENDAR = 'USER_GENDAR';
  static String USER_ID = "USER_ID";
  static String USER_AVATAR = "USER_AVATAR";
  static String USER_TOKEN = "USER_TOKEN";
  static String USER_EMAIL = "USER_EMAIL";
  static String USER_NAME = "USER_NAME";
  static String USER_EMP_CODE = "USER_EMP_CODE";
  static String USER_AUTH = "USER_AUTH";
  static String APP_IN_ENGLISH = "APP_IN_ENGLISH";
  static String USER_ADDRESS = "USER_ADDRESS";
  static String CHECK_STATUS = "0";
  static String totalWorkingHours = "0 hr 0 min";

  String greeting(BuildContext context) {
    var hour = DateTime.now().hour;

    if (hour >= 12 && hour < 17) {
      return '${'Afternoon'}🌞';
    } else if (hour >= 17 && hour < 21) {
      return '${"Evening"}🌙';
    } else if (hour >= 21 && hour < 3) {
      return "${"Night"}🌜";
    } else {
      return '${"morning"}🌞';
    }
  }
}
