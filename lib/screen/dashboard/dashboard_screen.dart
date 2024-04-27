import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';

import 'package:bmitserp/screen/dashboard/homescreen.dart';
import 'package:bmitserp/screen/dashboard/leaveandattendance_dash.dart';
import 'package:bmitserp/screen/dashboard/morescreen.dart';
import 'package:bmitserp/screen/dashboard/projectscreen.dart';
import 'package:bmitserp/service/push_notifications.dart';
import 'package:bmitserp/utils/showExitPopup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  //static const String routeName = '/';
  static const String routeName = '/dashboard';

  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  NotificationServices notificationServices = NotificationServices();
  Position? _currentPosition;
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ProjectScreen(),
      AttendanceScreenHistory(),
      MoreScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();
   
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    _handleLocationPermission();
    setupRemoteConfig();
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    bool serviceEnabled;
    if (permission == LocationPermission.denied) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(
                    " Prominent Disclosure Regarding Background Location Access"),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Background Location Usage:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our app will only access your device\'s location in the background when you initiate a check-in or check-out time only. When the  Employee check-out from the application, then location access of the device will be stop.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Limited to access location at Check-In and Check-Out time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This background location access is solely for the purpose of providing accurate check-in and check-out data and ensuring the efficiency of our service',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Purposeful Access',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our app manage and adjust location permissions within the settings of our app, providing you with full control over when and how your location information is accessed.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your Privacy Matters:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'We are committed to ensuring that your location data is used responsibly and transparently. We do not track your location continuously in the background, and your privacy is of utmost importance to us',
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Deny'),
                  ),
                  CupertinoDialogAction(
                    child: Text("Accept"),
                    onPressed: () async {
                      Navigator.pop(context);
                      permission = await Geolocator.requestPermission();

                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text(
    //           'Location services are disabled. Please enable the services')));
    //   return false;
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Location permissions are denied')));
    //     return false;
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text(
    //           'Location permissions are permanently denied, we cannot request permissions.')));
    //   return false;
    // }
    // return true;
    return true;
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: PersistentTabView(context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          backgroundColor: HexColor("#041033"),
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style11),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work_history),
        title: "Work",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.sick),
        title: "Leave",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.more),
        title: "Menu",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
    ];
  }

  setupRemoteConfig() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;



    final remoteConfig = FirebaseRemoteConfig.instance;

    remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
    await remoteConfig.fetch();
    await remoteConfig.activate();
    if (remoteConfig.getValue(APIURL.appUpdate).asBool()) {
      if (version != remoteConfig.getValue(APIURL.Version).asString() &&
          remoteConfig.getValue(APIURL.forceFully).asBool()) {
        _forceFullyupdate(remoteConfig.getString(APIURL.updateUrl),
            remoteConfig.getString(APIURL.updateMessage));
        return;
      }
      if (version != remoteConfig.getValue(APIURL.Version).asString()) {
        _update(remoteConfig.getString(APIURL.updateUrl),
            remoteConfig.getString(APIURL.updateMessage));
        return;
      }
    }
  }

  void _update(String url, String Message) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Update ! '),
            content: Text(Message),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text('May be later'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  _lunchInBrowser(url);
                },
                child: const Text('Update'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void _forceFullyupdate(
    String url,
    String Message,
  ) {
    showCupertinoDialog(
        context: context!,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: CupertinoAlertDialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              insetAnimationDuration: Duration(milliseconds: 600),
              title: const Text(
                'Update required !',
              ),
              content: Text(Message),
              actions: [
                // The "Yes" button

                // The "No" button
                CupertinoDialogAction(
                  onPressed: () {
                    _lunchInBrowser(url);
                  },
                  child: const Text('Update'),
                  isDefaultAction: false,
                  isDestructiveAction: false,
                )
              ],
            ),
          );
        });
  }

  Future<void> _lunchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{"headesr_key": "headers_value"});
    } else {
      throw "url not lunched $url";
    }
  }

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
}

// Future<bool>  showExitPopup(BuildContext context) async {
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('Exit app?'),
//       content: Text('Do you want to exit the app?'),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: Text('No'),
//         ),
//         ElevatedButton(
//           onPressed: () => Navigator.of(context).pop(true),
//           child: Text('Yes'),
//         ),
//       ],
//     ),
//   );
// }


