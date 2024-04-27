import 'dart:convert';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/projectdashboard/ProjectDashboardResponse.dart';
import 'package:bmitserp/model/member.dart';
import 'package:bmitserp/model/project.dart';
import 'package:bmitserp/model/task.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDashboardController extends GetxController {
  var overview = {
    "progress": 0,
    "total_task": 0,
    "task_completed": 0,
  }.obs;

  var taskList = [].obs;
  var projectList = [].obs;

  Future<String> getProjectOverview() async {
    var uri =
        Uri.parse(Constant.PROJECT_DASHBOARD_URL + "?tasks=10&projects=3");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final projectResponse = ProjectDashboardResponse.fromJson(responseData);

        taskList.clear();
        projectList.clear();

        overview.value['progress'] =
            projectResponse.data.progress.progress_in_percent;
        overview.value['total_task'] =
            projectResponse.data.progress.total_task_assigned;
        overview.value['task_completed'] =
            projectResponse.data.progress.total_task_completed;

        for (var task in projectResponse.data.assigned_task) {
          taskList.add(Task(task.task_id, task.task_name, task.project_name,
              task.start_date, task.end_date, task.status));
        }

        List<Member> members = [];
        for (var project in projectResponse.data.projects) {
          for (var member in project.assigned_member) {
            members.add(Member(member.id, member.name, member.avatar));
          }

          projectList.add(Project(
              project.id,
              project.project_name,
              "",
              project.start_date,
              project.priority,
              project.status,
              project.project_progress_percent,
              project.assigned_task_count,
              members, [], []));
        }

        return "Loaded";
      } else {
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void onInit() {
    // getProjectOverview();
    super.onInit();
  }
}
