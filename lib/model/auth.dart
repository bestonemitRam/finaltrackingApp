import 'dart:convert';
import 'dart:io';
import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/login/Loginresponse.dart';
import 'package:bmitserp/model/check_auth_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bmitserp/utils/deviceuuid.dart';
import 'package:bmitserp/utils/constant.dart';

class Auth with ChangeNotifier {
  Future<Loginresponse> login(String username, String password) async {
    var uri = Uri.parse(APIURL.LOGIN_API);

    Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    try {
      var fcm = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> Requestbody = {
        'employee_code': username,
        'password': password,
        'fcm_token': fcm,
        'device_type': Platform.isIOS ? 'ios' : 'android',
        'modal': androidInfo.model,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
        'product': androidInfo.product,
        'hardware': androidInfo.hardware,
      };
      print("fjkgkg  ${Requestbody}");
      final response =
          await http.post(uri, headers: headers, body: Requestbody);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = Loginresponse.fromJson(responseData);
        Preferences preferences = Preferences();

        await preferences.saveUser(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];

        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<CheckAuthModel> getMe() async {
    var uri = Uri.parse(APIURL.GET_ME);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    var fcm = await FirebaseMessaging.instance.getToken();
    print("fjkghkj  ${fcm}");
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
      'fcm_token': fcm.toString(),
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);
      final responseJson = CheckAuthModel.fromJson(responseData);
      if (response.statusCode == 200) {
        Preferences preferences = Preferences();
        await preferences.checkAuth(responseJson.result!.userData!,
            responseJson.result!.active_status.toString());
        return responseJson;
      } else {
        Preferences preferences = Preferences();
        preferences.clearPrefs();
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }
}
