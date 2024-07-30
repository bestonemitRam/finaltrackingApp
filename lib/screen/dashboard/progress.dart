import 'package:bmitserp/provider/projectdashboardcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgrsssTask extends StatelessWidget {
   ProgrsssTask({super.key});
    final model = Get.put(ProjectDashboardController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () => CircularPercentIndicator(
                  radius: 60.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 15.0,
                  percent: (model.overview.value['progress']! / 100),
                  center: Obx(
                    () => Text(
                      model.overview.value['progress'].toString() + "%",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.white12,
                  progressColor:
                      (model.overview.value['progress']! / 100) <= .25
                          ? HexColor("#C1E1C1")
                          : (model.overview.value['progress']! / 100) <= .50
                              ? HexColor("#C9CC3F")
                              : (model.overview.value['progress']! / 100) <= .75
                                  ? HexColor("#93C572")
                                  : HexColor("#3cb116"),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Progress Current Task",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Divider(
                    color: Colors.white54,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Obx(
                    () => Text(
                        model.overview.value['task_completed'].toString() +
                            " / " +
                            model.overview.value['total_task'].toString() +
                            " Task Completed",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  


  }
}