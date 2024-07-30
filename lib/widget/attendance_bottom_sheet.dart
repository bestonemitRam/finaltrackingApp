import 'package:bmitserp/provider/dashboardprovider.dart';
import 'package:bmitserp/widget/customalertdialog.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:bmitserp/widget/buttonborder.dart';

class AttedanceBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AttendanceBottomSheetState();
}

class AttendanceBottomSheetState extends State<AttedanceBottomSheet> {
  bool isEnabled = true;
  bool isLoading = false;

  void onCheckOut() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
        EasyLoading.show(
            status: "Requesting...", maskType: EasyLoadingMaskType.black);
      });
      var status = await provider.getCheckInStatus();
      if (status) {
        final response = await provider.checkOutAttendance();
        isEnabled = true;
        if (!mounted) {
          return;
        }
        setState(() {
          EasyLoading.dismiss(animation: true);
          Navigator.pop(context);
          isLoading = false;
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: CustomAlertDialog(response.message),
              );
            },
          );
        });
      }
    } catch (e) {
      setState(() {
        EasyLoading.dismiss(animation: true);
        isLoading = false;
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      });
    }
  }

  void onCheckIn() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    try {
      isLoading = true;
      setState(() {
        EasyLoading.show(
            status: "Requesting...", maskType: EasyLoadingMaskType.black);
      });
      print("fjkghgh ");
      var status = await provider.getCheckInStatus();

      print("fjkghgh ${status}");

      if (status) {
        bool result = await InternetConnectionChecker().hasConnection;

        if (result) 
        {
       

          final response = await provider.checkInAttendance();
       
          isEnabled = true;
          if (!mounted) {
            return;
          }
          setState(() {
            EasyLoading.dismiss(animation: true);
            Navigator.pop(context);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog(response.message),
                );
              },
            );
          });
        } else {
          setState(() {
            EasyLoading.dismiss(animation: true);
            Navigator.pop(context);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog("No Internet connection!"),
                );
              },
            );
          });
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        EasyLoading.dismiss(animation: true);
        Navigator.pop(context);
        isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Check in/out',
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
                              isEnabled ? onCheckIn() : null;
                              isEnabled = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Check in',
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
                              isEnabled ? onCheckOut() : null;
                              isEnabled = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Check out',
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
      ),
    );
  }
}
