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
import 'package:bmitserp/screen/task/task_details.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/leavescreen/issueleavesheet.dart';
import 'package:bmitserp/widget/leavescreen/leave_list_detail_dashboard.dart';
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

  var init = true;
  var isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final taskprovider = Provider.of<MyTaskProvider>(context, listen: false);
    final taskdata = await taskprovider.getDailyTask();

    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }
    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<MyTaskProvider>(context, listen: true);
    final taskdata = leaveData.taskModelData;

    return Container(
      decoration: RadialDecoration(),
      child: Container(
          decoration: RadialDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ListView.builder(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Task : ",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Text(
                                          "${task.taskName}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: HexColor("#036eb7"),
                                              fontSize: 14),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(DailyTaskDetails(
                                            task_id: task.id.toString(),
                                          ));
                                        },
                                        child: Text(
                                          "Details..",
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Task Date : ",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Text(
                                          "${messageTime(task.startingDate)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: HexColor("#036eb7"),
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "End Task Date : ",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Text(
                                          "${messageTime(task.endingDate)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: HexColor("#036eb7"),
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  if (task.isTargetProductDetails.toString() ==
                                      '1')
                                    orders(task.targetProductDetails),
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
          )),
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
