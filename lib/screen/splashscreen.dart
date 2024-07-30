import 'dart:async';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/utils/check_internet_connectvity.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    checkAuthentication();
    // Timer(
    //   const Duration(milliseconds: 1000),
    //   () async {
    //     try {
    //       bool result = await InternetConnectionChecker().hasConnection;
    //       if (result == true) {
    //         var response =
    //             await Provider.of<Auth>(context, listen: false).getMe();
    //         Preferences preferences = Preferences();
    //         String token = await preferences.getToken();

    //         print("kjdfhgkj  ${token}");

    //         if (token == '') {
    //           Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    //         } else {
    //           Navigator.pushReplacementNamed(
    //               context, DashboardScreen.routeName);
    //         }
    //       } else {
    //         Navigator.pushReplacementNamed(
    //             context, InternetNotAvailable.routeName);
    //       }
    //     } catch (e) {}
    //   },
    // );
    super.initState();
  }

  Future<void> checkAuthentication() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Timer(
        const Duration(milliseconds: 1000),
        () async {
          try {
            var response = await Provider.of<Auth>(context, listen: false).getMe();
            Preferences preferences = Preferences();
            String token = await preferences.getToken();

            print("kjdfhgkj  ${token}  ${response.status}");

            if (token == '') 
            {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            } else {
              Navigator.pushReplacementNamed(
                  context, DashboardScreen.routeName);
            }
          } catch (e) {}
        },
      );
    } else {
      Navigator.pushReplacementNamed(context, InternetNotAvailable.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Center(
          child: Image.asset(
        "assets/icons/logo_bnw.png",
        width: 120,
        height: 120,
      )),
    );
  }
}
