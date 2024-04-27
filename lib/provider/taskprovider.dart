import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/home_page_model.dart';
import 'package:bmitserp/model/my_task.dart';
import 'package:bmitserp/model/task_details.dart';
import 'package:bmitserp/model/task_madel.dart';
import 'package:bmitserp/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyTaskProvider with ChangeNotifier {
  MyTask mytaskModel = MyTask();
  List<TaskListPending> allData = [];
  List<TaskListPending> get taskListtData => allData;
  List<TaskListPending> allDataCompleted = [];
  List<TaskListPending> get allDataCompletedlist => allDataCompleted;
  bool datanotfound = false;

  Future getMyTask() async {
    allData = [];
    var url = APIURL.GET_ALL_TASK;

    ServiceWithHeader service = ServiceWithHeader(url);
    final response = await service.data();

    mytaskModel = MyTask.fromJson(response);
    allData = [];

    if (mytaskModel.data != null) {
      if (mytaskModel.data != null) {
        if (mytaskModel.data!.taskListPending!.isNotEmpty) {
          for (int i = 0; i < mytaskModel.data!.taskListPending!.length; i++) {
            allData.add(mytaskModel.data!.taskListPending![i]);
          }
        }
        if (mytaskModel.data!.taskListCompleted!.isNotEmpty) {
          for (int i = 0;
              i < mytaskModel.data!.taskListCompleted!.length;
              i++) {
            allDataCompleted.add(mytaskModel.data!.taskListCompleted![i]);
          }
        }
      }
    }
    datanotfound = true;
    notifyListeners();
    return;
  }

  TaskModel taskModel = TaskModel();

  final List<TaskModelData> _taskModelData = [];
  List<TaskModelData> get taskModelData {
    return [..._taskModelData];
  }

  Future getDailyTask() async {
    var uri = Uri.parse(APIURL.DAILY_TASK);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await http.post(uri, headers: headers, body: {
        'filterDate': formattedDate,
      });

      final responseData = json.decode(response.body);
      print('dfhgkgfkjfgjk ${response.body}  ${response.statusCode}');

      if (response.statusCode == 200) {
        taskModel = TaskModel.fromJson(responseData);

        makeDailyTask(taskModel);
      } else {
        makeDailyTask(taskModel);
      }
    } catch (e) {}
  }

  void makeDailyTask(TaskModel data) {
    _taskModelData.clear();

    for (var datas in data.result!) {
      _taskModelData.add(datas);
    }

    notifyListeners();
  }








}
