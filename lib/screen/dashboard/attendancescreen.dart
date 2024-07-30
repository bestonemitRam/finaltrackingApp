import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:bmitserp/widget/attendancescreen/attendancestatus.dart';
import 'package:bmitserp/widget/attendancescreen/attendancetoggle.dart';
import 'package:bmitserp/widget/attendancescreen/reportlistview.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget 
{
  @override
  State<StatefulWidget> createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
  var initial = true;

  @override
  void didChangeDependencies() 
  {
    if (initial) {
      loadAttendanceReport();
      initial = false;
    }
    super.didChangeDependencies();
  }

  Future<String> loadAttendanceReport() async {
    try {
      await Provider.of<AttendanceReportProvider>(context, listen: false)
          .getAttendanceReport();

      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [AttendanceToggle(), ReportListView()],
                ),
              ),
            ),
          )),
      // ),
    );
  }
}
