import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/leave_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListdetailDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context);
    final leaves = leaveData.leaveDetailList;
 
    if (leaves.length > 0) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: leaves.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: LeaveDetailRow(
                  id: leaves[i].id,
                  name: leaves[i].name,
                  from: leaves[i].leave_from,
                  to: leaves[i].leave_to,
                  status: leaves[i].status,
                  authorization: leaves[i].authorization,
                  requestedAt: leaves[i].requested_date),
            );
          });
    } else {
      return const SizedBox(
        height: 50,
      );
    }
  }
}
