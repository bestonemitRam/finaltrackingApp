import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/leavescreen/leave_list_dashboard.dart';
import 'package:bmitserp/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:bmitserp/widget/leavescreen/leavebutton.dart';
import 'package:bmitserp/widget/leavescreen/leavetypefilter.dart';
import 'package:bmitserp/widget/leavescreen/toggleleavetime.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/provider/leaveprovider.dart';

class LeaveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaveScreenState();
}

class LeaveScreenState extends State<LeaveScreen> {
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
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    leaveProvider.selectLeaveType();
    final leaveData = await leaveProvider.getLeaveType();

    if (!mounted) {
      return "Loaded";
    }
    // if (leaveData.statusCode != 200)
    //  {
    //   showToast(leaveData!.message!);
    // }

    getLeaveDetailList();
    return "Loaded";
  }

  void getLeaveDetailList() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final detailResponse = await leaveProvider.getLeaveTypeDetail();

    if (!mounted) {
      return;
    }
    // if (detailResponse.statusCode == 200)
    // {
    //   isVisible = true;
    //   if (detailResponse.data!.leaveList!.isEmpty)
    //    {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         padding: EdgeInsets.all(20), content: Text('No data found')));
    //    }
    // }
    //  else
    //   {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       padding: EdgeInsets.all(20), content: Text(detailResponse.message!)));
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LeaveListDashboard(),
                    Visibility(
                      visible: true,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: LeaveButton()),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 25),
                            child: Card(
                              color: Colors.white12,
                              shape: ButtonBorder(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: true,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10),
                                          child: Filter()),
                                    ),
                                    Visibility(
                                        visible: true,
                                        child: LeaveListdetailDashboard()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Visibility(
                            visible: true,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: ToggleLeaveTime()),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
      //),
    );
  }
}
