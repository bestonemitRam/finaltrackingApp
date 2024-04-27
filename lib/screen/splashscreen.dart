import 'dart:async';

import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/model/auth.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/screen/dashboard/dashboard_screen.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
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
    Timer(
      const Duration(milliseconds: 1000),
      () async {
        try {
          bool result = await InternetConnectionChecker().hasConnection;
          if (result == true) {
            final response = await Provider.of<Auth>(context, listen: false).getMe();
            Preferences preferences = Preferences();
            String result = await preferences.getToken();
            print('check token  ${result}');
            if (result == '')
             {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            } else {
              Navigator.pushReplacementNamed(
                  context, DashboardScreen.routeName);
            }
          } else {}
        } catch (e) {}
      },
    );
    super.initState();
  }

  Future<String> loadAttendanceReport() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        final response =
            await Provider.of<Auth>(context, listen: false).getMe();
      } else {}

      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  void didChangeDependencies() {
    loadAttendanceReport();
    super.didChangeDependencies();
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
