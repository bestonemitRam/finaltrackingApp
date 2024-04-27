import 'dart:io';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<bool> showExitPopup(context) async {
  print("kfdjgkgjh");
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
                  "If you closed app then you check out form the device",
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
