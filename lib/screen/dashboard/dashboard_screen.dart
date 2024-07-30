import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/provider/notificationprovider.dart';

import 'package:bmitserp/screen/dashboard/homescreen.dart';
import 'package:bmitserp/screen/dashboard/leaveandattendance_dash.dart';
import 'package:bmitserp/screen/dashboard/morescreen.dart';
import 'package:bmitserp/screen/dashboard/projectscreen.dart';
import 'package:bmitserp/screen/profile/NotificationScreen.dart';
import 'package:bmitserp/service/push_notifications.dart';
import 'package:bmitserp/utils/showExitPopup.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
  // List<Widget> _pages()
  // {
  //   return [
  //     HomeScreen(),
  //     ProjectScreen(),
  //     AttendanceScreenHistory(),
  //     MoreScreen(),
  //   ];
  // }

  final List<Widget> _pages = [
    HomeScreen(),
    ProjectScreen(),
    AttendanceScreenHistory(),
    MoreScreen(),
  ];
  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);


    _handleLocationPermission();
    setupRemoteConfig();
  }

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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

    return true;
  }

  @override
  Widget build(BuildContext context) {
  

    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor:
          //       Colors.transparent, // Make the AppBar background transparent
          //   flexibleSpace: Container(
          //     decoration: BoxDecoration(
          //       gradient: RadialGradient(
          //         colors: [
          //           HexColor("#011754"),
          //           HexColor("#041033"),
          //         ],
          //         center: Alignment.center,
          //         radius: 0.8,
          //       ),
          //     ),
          //   ),
          //   title: Container(
          //     padding: EdgeInsets.only(top: 10),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "${Apphelper().greeting(context)}",
          //           style: TextStyle(color: Colors.white, fontSize: 12),
          //         ),
          //         if (Apphelper.USER_NAME != '')
          //           Text(
          //             Apphelper.USER_NAME ?? " ",
          //             style: TextStyle(color: Colors.white, fontSize: 12),
          //           ),
          //         Text(
          //           //sharedPref.getString(Apphelper.USER_EMP_CODE) ?? "",
          //           '',
          //           style: TextStyle(color: Colors.white, fontSize: 12),
          //         ),
          //       ],
          //     ),
          //   ),
          //   leading: Padding(
          //     padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 8),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(25),
          //           child: Image.network(
          //             // APIURL.imageURL + Apphelper.USER_AVATAR.toString(),
          //             '',
          //             //   width: 50,
          //             //  height: 50,
          //             fit: BoxFit.cover,
          //             errorBuilder: (context, error, stackTrace) {
          //               return Image.asset(
          //                 'assets/images/dummy_avatar.png',
          //                 //    width: 50,
          //                 //   height: 50,
          //                 fit: BoxFit.cover,
          //               );
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Center(
          //         child: Stack(
          //           alignment: Alignment.center,
          //           children: [
          //             IconButton(
          //               icon: Icon(
          //                 Icons.notifications,
          //                 color: Colors.white,
          //               ),
          //               onPressed: () {
          //                 Get.to(() => NotificationScreen(),
          //                     transition: Transition.fade);
          //               },
          //             ),
          //             // if (notificationProvider.unreadCount >= 0)
          //             //   Positioned(
          //             //     right: 10,
          //             //     child: Container(
          //             //       padding: EdgeInsets.all(1),
          //             //       decoration: BoxDecoration(
          //             //         color: Colors.red,
          //             //         borderRadius: BorderRadius.circular(6),
          //             //       ),
          //             //       constraints: BoxConstraints(
          //             //         minWidth: 12,
          //             //         minHeight: 12,
          //             //       ),
          //             //       child: Text(
          //             //         '${notificationProvider.unreadCount}',
          //             //         style: TextStyle(
          //             //           color: Colors.white,
          //             //           fontSize: 8,
          //             //         ),
          //             //         textAlign: TextAlign.center,
          //             //       ),
          //             //     ),
          //             //   )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        
        
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            items: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_filled, size: 20),
                    Text(
                      "Home",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sick, size: 20),
                    Text(
                      "Work",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 20),
                    Text(
                      "History",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.more, size: 20),
                    Text(
                      "Menu",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: _pages[_page],
        )
        // PersistentTabView(
        //   context,
        //     controller: _controller,
        //     screens: _buildScreens(),
        //     items: _navBarsItems(),
        //     handleAndroidBackButtonPress: true,
        //     resizeToAvoidBottomInset: true,
        //     stateManagement: true,
        //     hideNavigationBarWhenKeyboardShows: true,
        //     decoration: NavBarDecoration(
        //       borderRadius: BorderRadius.circular(0.0),
        //       colorBehindNavBar: Colors.white,
        //     ),
        //     popAllScreensOnTapOfSelectedTab: true,
        //     popActionScreens: PopActionScreensType.all,
        //     navBarStyle: NavBarStyle.style11),

        );
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home_filled),
  //       title: "Home",
  //       activeColorPrimary: Colors.white,
  //       inactiveColorPrimary: Colors.white30,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.work_history),
  //       title: "Work",
  //       activeColorPrimary: Colors.white,
  //       inactiveColorPrimary: Colors.white30,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.sick),
  //       title: "Leave",
  //       activeColorPrimary: Colors.white,
  //       inactiveColorPrimary: Colors.white30,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.more),
  //       title: "Menu",
  //       activeColorPrimary: Colors.white,
  //       inactiveColorPrimary: Colors.white30,
  //     ),
  //   ];
  // }

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
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 14.h,
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
