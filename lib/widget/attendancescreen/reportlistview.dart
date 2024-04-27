import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/attendancescreen/attendancecardview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReportListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attendanceList =
        Provider.of<AttendanceReportProvider>(context).attendanceReport;
    if (attendanceList.isNotEmpty) {
      return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                attendanceReportTitle(),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: attendanceList.length,
                    itemBuilder: (ctx, i) {
                      return AttendanceCardView(
                        i,
                        attendanceList[i].attendance_date!,
                        attendanceList[i].total_working_hour!,
                        attendanceList[i].check_in!,
                        attendanceList[i].check_out!,
                      );
                    }),
              ],
            )),
      );
    } else {
      return Provider.of<AttendanceReportProvider>(context).loader
          ? Visibility(
              visible: Provider.of<AttendanceReportProvider>(context).loader
                  ? true
                  : false,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: 50.h,
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
    }
  }

  Widget attendanceReportTitle() {
    return Card(
      elevation: 0,
      color: Colors.black38,
      shape: ButtonBorder(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                child: Text('Date',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              child: Container(
                child: Text('Working',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              child: Container(
                child: Text('Start Time',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('End Time',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
