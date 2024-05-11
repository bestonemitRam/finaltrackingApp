import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/provider/morescreenprovider.dart';
import 'package:bmitserp/screen/auth/login_screen.dart';
import 'package:bmitserp/utils/navigationservice.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/buttonborder.dart';

class LogOutBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogOutBottomSheetState();
}

class LogOutBottomSheetState extends State<LogOutBottomSheet> {
  void logout() async {
    try {
      setState(() {
        showLoader();
      });
      final response =
          await Provider.of<MoreScreenProvider>(context, listen: false)
              .logout();

      setState(() {
        dismissLoader();
      });
      if (!mounted) {
        return;
      }
      if (response.status.toString() == "true" ||
          response.status.toString() == "false") {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return LoginScreen();
            },
          ),
          (_) => false,
        );
      }
    } catch (e) {
      NavigationService().showSnackBar("Log out Alert", e.toString());
      setState(() {
        dismissLoader();
      });
    }
  }

  void dismissLoader() {
    setState(() {
      EasyLoading.dismiss(animation: true);
    });
  }

  void showLoader() {
    setState(() {
      EasyLoading.show(
          status: "Logging Out, Please Wait..",
          maskType: EasyLoadingMaskType.black);
    });
  }

  checkLocation() async {
    print("dkjshgjhsdjkfgjksdhgfjk");
    final service = FlutterBackgroundService();

    service.invoke("stopService");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Are you sure you want to  logout from the application?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("#036eb7"),
                              shape: ButtonBorder()),
                          onPressed: () async {
                            checkLocation();
                            logout();
                            Apphelper.totalWorkingHours = "0 hr 0 min";
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: HexColor("#036eb7"),
                              shape: ButtonBorder()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Go back',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
