import 'dart:async';

import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/utils/check_internet_connectvity.dart';
import 'package:bmitserp/utils/check_internet_connectvity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/source/datastore/preferences.dart';


class InternetNotAvailable extends StatefulWidget {
  static const String routeName = '/internetNotAvailable';

  InternetNotAvailable({super.key, double? height});

  @override
  State<InternetNotAvailable> createState() => _InternetNotAvailableState();
}

class _InternetNotAvailableState extends State<InternetNotAvailable> {
  double? height;
  bool isRefresh = false;

  Future<void> reloadScreen() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        Timer(const Duration(milliseconds: 1000), () async {
          var response =
              await Provider.of<Auth>(context, listen: false).getMe();
          Preferences preferences = Preferences();
          String token = await preferences.getToken();

          print("kjdfhgkj  ${token}  ${response}");

          if (token == '') {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
          }
        });
      } else {
        isRefresh = false;
        Fluttertoast.showToast(
            msg: "Try again !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 55.h,
        //   width: 50.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_internet.png',
                width: 50.w,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "No Internet Connection",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Check your connection, Then refresh the page.",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  setState(() 
                  {
                    isRefresh = true;
                  });
                  reloadScreen();
                },
                child: Column(
                  children: [
                    !isRefresh
                        ? Icon(Icons.refresh)
                        : CircularProgressIndicator(
                            color: Colors.black,
                          ),
                    Text(
                      "Please refresh !",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
