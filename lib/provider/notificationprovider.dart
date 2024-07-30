import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/notification/NotifiactionDomain.dart';
import 'package:bmitserp/data/source/network/model/notification/NotificationResponse.dart';
import 'package:bmitserp/data/source/network/model/notification/NotificationResponse.dart';
import 'package:bmitserp/model/notification_response.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bmitserp/model/notification.dart' as Not;
import 'package:intl/intl.dart';

import '../data/source/network/model/notification/NotificationResponse.dart';

class NotificationProvider with ChangeNotifier {
  static int per_page = 10;
  int page = 1;

  final List<NotificationData> _notificationList = [];

  List<NotificationData> get notificationList {
    return [..._notificationList];
  }

  List<NotificationData> _notifications = [];

  List<NotificationData> get notifications => _notifications;
  int get unreadCount {
    return _notifications
        .where((notification) => notification.readStatus == 0)
        .length;
  }

  Future<NotificationResponse> getNotification() async {
    var uri = Uri.parse(APIURL.allNotifications);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = 
    {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = NotificationResponse.fromJson(responseData);

        makeNotificationList(jsonResponse.result!);
        return jsonResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  void makeNotificationList(List<NotificationData> data)
   {
    _notificationList.clear();
    _notifications.clear();

    if (data.isNotEmpty) {
      for (var item in data) {
        DateTime tempDate = DateFormat("yyyy-MM-dd").parse(item.createdAt);
        _notificationList.add(item);
        _notifications.add(item);
      }

      page += page;
    }

    notifyListeners();
  }

  //changeStatusToReadNotifications
  Future<ChangeNotificationResponse> changeNotification(
      int notification) async {
    var uri =
        Uri.parse(APIURL.changeStatusToReadNotifications + "${notification}");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      markAsRead(notification);

      if (response.statusCode == 200) {
        final jsonResponse = ChangeNotificationResponse.fromJson(responseData);

        return jsonResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  void markAsRead(int id) {
    final index =
        _notifications.indexWhere((notification) => notification.id == id);

    if (index != -1) {
      _notifications[index] = NotificationData(
        id: _notifications[index].id,
        readStatus: 1,
      );
      notifyListeners();
    }
  }
}
