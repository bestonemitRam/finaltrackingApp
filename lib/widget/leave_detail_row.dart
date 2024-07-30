import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/cancel_leave_bottom_sheet.dart';
import 'package:bmitserp/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveDetailRow extends StatelessWidget {
  final int id;
  final String name;
  final String from;
  final String to;
  final String status;
  final String authorization;
  final String requestedAt;

  LeaveDetailRow(
      {required this.id,
      required this.name,
      required this.from,
      required this.to,
      required this.status,
      required this.authorization,
      required this.requestedAt});

  @override
  Widget build(BuildContext context) 
  {
    void onLeaveCancelledClicked(int id) 
    {
      showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) {
            return CancelLeaveBottomSheet(id);
          });
    }

    String dateTime(String time) {
      DateTime dt = DateTime.parse(time);

      final localTime = dt.toLocal();
      var inputDate = DateTime.parse(localTime.toString());
      var outputFormat = DateFormat('dd-MM-yyyy ').format(inputDate);

      return outputFormat;
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "${dateTime(from)} - ${dateTime(to)}",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Text(
                    authorization == '' ? "N/A" : "By: $authorization",
                    style: TextStyle(color: HexColor("#036eb7"), fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      requestedAt,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (status.toLowerCase() == "pending") {
                      //   onLeaveCancelledClicked(id);
                      // }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: getStatus(),
                        child: Text(
                          status,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getStatus() {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.redAccent;
      case "Pending":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

}
