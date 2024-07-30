import 'dart:io';

import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/model/DataModel.dart';
import 'package:bmitserp/model/advance_order.dart';
import 'package:bmitserp/model/order_list.dart';
import 'package:bmitserp/model/task_madel.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:bmitserp/provider/taskprovider.dart';

import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/selcet_shop.dart';
import 'package:bmitserp/screen/shop_module/shop_list.dart';
import 'package:bmitserp/screen/task/calendar.dart';
import 'package:bmitserp/screen/task/task_details.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/leavescreen/issueleavesheet.dart';
import 'package:bmitserp/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:bmitserp/widget/leavescreen/leavebutton.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DailyTask extends StatefulWidget {
  DailyTask({
    super.key,
  });

  @override
  State<DailyTask> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DailyTask> {
  final RetailerController controller = Get.put(RetailerController());
  TextEditingController endDate = TextEditingController();
  String endDateTime = '';

  var init = true;
  var isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    endDate.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final taskprovider = Provider.of<MyTaskProvider>(context, listen: false);
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final taskdata = await taskprovider.getDailyTask(formattedDate);

    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }
    return "Loaded";
  }

  static String dateTime(String time) {
    DateTime dt = DateTime.parse(time);

    final localTime = dt.toLocal();
    var inputDate = DateTime.parse(localTime.toString());
    var outputFormat = DateFormat('dd-MM-yyyy ').format(inputDate);

    return outputFormat;
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<MyTaskProvider>(context, listen: true);
    final taskdata = leaveData.taskModelData;

    print("lkjfgkgfhjkjgf  ${taskdata.length}");

    return Container(
      decoration: RadialDecoration(),
      child: Container(
          decoration: RadialDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              // gaps(10),
              // TextField(
              //   controller: endDate,
              //   style: TextStyle(color: Colors.white),
              //   //editing controller of this TextField
              //   cursorColor: Colors.white,
              //   decoration: InputDecoration(
              //     hintText: 'Filter Date',
              //     hintStyle: TextStyle(color: Colors.white),
              //     prefixIcon: Icon(Icons.calendar_month, color: Colors.white),
              //     labelStyle: TextStyle(color: Colors.white),
              //     fillColor: Colors.white24,
              //     filled: true,
              //     enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(0),
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(10))),
              //     focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(0),
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(10))),
              //     focusedErrorBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(0),
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(10))),
              //     errorBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(0),
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(10))),
              //   ),
              //   readOnly: true,
              //   //set it true, so that user will not able to edit text
              //   onTap: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(1950),
              //         //DateTime.now() - not to allow to choose before today.
              //         lastDate: DateTime(2100));

              //     if (pickedDate != null) {
              //       String formattedDate =
              //           DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);

              //       setState(() {
              //         endDateTime = formattedDate;
              //         endDate.text = dateTime(formattedDate);
              //       });
              //     } else {}
              //   },
              // ),

              Visibility(
                visible: true,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: HexColor("#036eb7"),
                                  shape: ButtonBorder()),
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  final taskprovider =
                                      Provider.of<MyTaskProvider>(context,
                                          listen: false);
                                  final taskdata = await taskprovider
                                      .getDailyTask(formattedDate);

                                  setState(() {
                                    endDateTime = formattedDate;
                                    endDate.text = dateTime(formattedDate);
                                  });
                                } else {}
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Filter Date  : ${endDate.text}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        )),
                      ],
                    )),
              ),
              taskdata.length >= 0
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: taskdata.length,
                      itemBuilder: (context, index) {
                        final task = taskdata[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            child: Container(
                              color: Colors.white12,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          textBaseline: TextBaseline.alphabetic,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Task Date : ",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Text(
                                                    "${messageTime(task.taskDate!)}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#036eb7"),
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Task Deadline : ",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Text(
                                                    "${messageTime(task.taskDeadline!)}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#036eb7"),
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // if (status.toLowerCase() == "pending") {
                                                    //   onLeaveCancelledClicked(id);
                                                    // }
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      color: getStatus(
                                                          task.taskStatus!),
                                                      child: Text(
                                                        task.taskStatus!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () 
                                                  {
                                                    Get.to(DailyTaskDetails(
                                                      task_id:  task.id.toString(),
                                                    ));
                                                  },
                                                  child: Text(
                                                    "Task Details..",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // if (task.isTargetProductDetails
                                            //         .toString() ==
                                            //     '1')
                                            // orders(task.targetProductDetails),
                                            //orders()
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Sorry! don't have a task",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }

  Widget orders() {
    return Card(
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
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        textAlign: TextAlign.start),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text('Target',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
              //itemCount: targetProductDetails!.length,
              itemCount: 2,
              itemBuilder: (context, index) {
                //final data = targetProductDetails![index];
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
                                // "${data.productName} ${data.typeName} ${data.uomName}   ",
                                "productName typeName uomName",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                textAlign: TextAlign.start),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                                // '${data.targetQuantity} case',
                                'targetQuantity case ',
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
    );
  }

  Color getStatus(String s) {
    switch (s) {
      case "achieved":
        return Colors.green;

      case "pending":
        return Colors.orange;

      default:
        return Colors.orange;
    }
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
