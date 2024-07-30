import 'package:bmitserp/model/project.dart';
import 'package:bmitserp/model/task.dart';
import 'package:bmitserp/provider/projectdashboardcontroller.dart';
import 'package:bmitserp/screen/distributors/create_distributor_screen.dart';
import 'package:bmitserp/screen/inventory_module/create_inventory.dart';
import 'package:bmitserp/screen/projectscreen/projectdetailscreen/projectdetailscreen.dart';
import 'package:bmitserp/screen/projectscreen/projectlistscreen/projectlistscreen.dart';
import 'package:bmitserp/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:bmitserp/screen/projectscreen/tasklistscreen/tasklistscreen.dart';
import 'package:bmitserp/screen/task/daily_task.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_stack/image_stack.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectScreen extends StatelessWidget {
  final model = Get.put(ProjectDashboardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: Colors.white,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () {
            return model.getProjectOverview();
          },
          child: SafeArea(
              child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  HeaderProfile(),
                 // projectOverview(),
                  DailyTask(),
              
                  // recentProject(),
                  // recentTasks()
              
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

 

}
