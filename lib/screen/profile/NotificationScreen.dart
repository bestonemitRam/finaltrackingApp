import 'package:bmitserp/provider/notificationprovider.dart';
import 'package:bmitserp/widget/notification/notificationlist.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationScreen> {
  // var initial = true;

  // Future<String> getNotification() async
  //  {
  //   await Provider.of<NotificationProvider>(context, listen: false)
  //       .getNotification();

  //   return "Loaded";
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Notifications",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            //leading: ,

            // leading: InkWell(
            //   child: Icon(
            //     Icons.arrow_back_ios,
            //     color: Colors.white,
            //   ),
            //   onTap: ()
            //    {
            //     Get.back();
            //   },
            // ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: NotificationList()),
    );
  }
}
