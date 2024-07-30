import 'dart:async';
import 'dart:io';

import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/data/source/network/model/login/User.dart';
import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/provider/notificationprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/screen/dashboard/progress.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/utils/locationstatus.dart';
import 'package:bmitserp/widget/homescreen/checkattendance.dart';
import 'package:bmitserp/widget/homescreen/overviewdashboard.dart';

import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _startBackgroundLocationUpdates();
  
  }

  Future<void> _startBackgroundLocationUpdates() async {
    final service = FlutterBackgroundService();
    print("kdjfhgjkhg  ${Apphelper.CHECK_STATUS}");
    if (Apphelper.CHECK_STATUS.toString() == "1") {
      service.invoke("stopService");
    }
  }

  void didChangeDependencies() {
    loadDashboard();

    super.didChangeDependencies();
  }

  void locationStatus() async {
    try {
      final position = await LocationStatus().determinePosition();
      if (!mounted) {
        return;
      }
      final location =
          Provider.of<DashboardProvider>(context, listen: false).locationStatus;
      location.update('latitude', (value) => position.latitude);
      location.update('longitude', (value) => position.longitude);
    } catch (e) {
      print(e);
      showToast(e.toString());
    }
  }

  Future<String> loadDashboard() async {
    try {
      final dashboardProvider =
          await Provider.of<DashboardProvider>(context, listen: false)
              .getDashboardData();
                final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false).getNotification();
      return 'loaded';
    } catch (e) {
      print(e);
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Container(
          decoration: RadialDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: Colors.white,
              backgroundColor: Colors.blueGrey,
              edgeOffset: 50,
              onRefresh: () {
                return loadDashboard();
              },
              child: SafeArea(
                  child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      HeaderProfile(),
                      CheckAttendance(),
                      ProgrsssTask(),
                      OverviewDashboard(),
                      // WeeklyReportChart()
                    ],
                  ),
                ),
              )),
            ),
          ),
        ));
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are you sure you want to closed app",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent),
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text("No", style: TextStyle(fontSize: 16.sp)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
