import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/task_details.dart';

import 'package:bmitserp/widget/buttonborder.dart';

import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class DailyTaskDetails extends StatefulWidget {
  final String task_id;
  DailyTaskDetails({super.key, required this.task_id});

  @override
  State<DailyTaskDetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DailyTaskDetails> {
  TaskDetails taskDetails = TaskDetails();
  bool dataNotfound = false;
  Future getDailyTaskDetails() async {
    var uri = Uri.parse(APIURL.DAILY_TASK_DETAILS);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.post(uri, headers: headers, body: {
        'task_id': widget.task_id,
      });

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          dataNotfound = true;
          taskDetails = TaskDetails.fromJson(responseData);
        });
      } else {
        setState(() {
          dataNotfound = true;
          taskDetails = TaskDetails.fromJson(responseData);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getDailyTaskDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dataNotfound
        ? Container(
            decoration: RadialDecoration(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                title: Center(
                  child: Text(
                    "Task Details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Container(
                    color: Colors.white12,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  if (taskDetails.result!.isTargetProductDetails
                                          .toString() ==
                                      '1')
                                    orders(taskDetails
                                        .result!.targetProductDetails),
                                  if (taskDetails.result!.isTargetProductDetails
                                          .toString() ==
                                      '1')
                                    Divider(),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "${taskDetails.result!.taskDescription}",
                                      //  overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: HexColor("#036eb7"),
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget orders(List<TargetProductDetails>? targetProductDetails) {
    return targetProductDetails!.isNotEmpty
        ? Card(
            elevation: 0,
            color: Colors.black38,
            shape: ButtonBorder(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Product Type',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
                              textAlign: TextAlign.start),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text('Target',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: targetProductDetails!.length,
                    itemBuilder: (context, index) {
                      final data = targetProductDetails![index];
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                      "${data.productName} ${data.typeName} ${data.uomName}   ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text('${data.targetQuantity} case',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                      textAlign: TextAlign.start),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Center();
  }

  static String messageTime(String time) {
    DateTime dt = DateTime.parse(time);
    print("converted gmt date >> " + dt.toString());
    final localTime = dt.toLocal();
    print("local modified date >> " + localTime.toString());

    var inputDate = DateTime.parse(localTime.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

    var outputDate = outputFormat.format(inputDate);

    String formattedTime = DateFormat('dd-MM-yyyy ').format(inputDate);

    return formattedTime;
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
