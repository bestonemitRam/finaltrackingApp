import 'package:bmitserp/api/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class NoDataFoundErrorScreens extends StatelessWidget {
  double? height;
  final String title;
  NoDataFoundErrorScreens({
    super.key,
    this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 75.h,
        width: 100.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/error.png',
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
