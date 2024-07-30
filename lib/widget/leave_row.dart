import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeaveRow extends StatelessWidget {
  final int id;
  final String name;
  final int allocated;
  final int used;

  LeaveRow(this.id, this.name, this.used, this.allocated);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              name,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  used.toString(),
                  style: TextStyle(
                    fontSize: 23.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(
                  visible: (allocated == 0) ? false : true,
                  child: const Text(
                    '/',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Visibility(
                  visible: (allocated == 0) ? false : true,
                  child: Text(
                    allocated.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
