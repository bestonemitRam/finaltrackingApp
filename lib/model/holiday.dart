import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class Holiday with ChangeNotifier {
  int id;
  String day;
  String month;
  String title;
  String description;
  DateTime dateTime;

  Holiday(
      {required this.id,
      required this.day,
      required this.month,
      required this.title,
      required this.description,
      required this.dateTime});
}
