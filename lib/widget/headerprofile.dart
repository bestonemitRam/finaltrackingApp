import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/main.dart';
import 'package:bmitserp/provider/notificationprovider.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/provider/profileUserProvider.dart';
import 'package:bmitserp/screen/profile/NotificationScreen.dart';
import 'package:bmitserp/screen/profile/new_profileScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class HeaderProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    // notificationProvider.getNotification();

    return GestureDetector(
      onTap: () {
        // Get.to(
        //     () => ChangeNotifierProvider<ProfileUserProvider>(
        //         create: (BuildContext context) => ProfileUserProvider(),
        //         child: ProfileScreenActivity()),
        //     transition: Transition.fade);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                APIURL.imageURL + Apphelper.USER_AVATAR.toString(),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace)
                 {
                  return Image.asset(
                    'assets/images/dummy_avatar.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello There',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  if (Apphelper.USER_NAME != '')
                    Text(
                      Apphelper.USER_NAME ?? " ",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  Text(
                    sharedPref.getString(Apphelper.USER_EMP_CODE) ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            Spacer(),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => NotificationScreen(),
                            transition: Transition.fade);
                      },
                    ),
                    if (notificationProvider.unreadCount >= 0)
                      Positioned(
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${notificationProvider.unreadCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
