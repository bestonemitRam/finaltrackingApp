import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/main.dart';
import 'package:bmitserp/provider/prefprovider.dart';
import 'package:bmitserp/provider/profileUserProvider.dart';
import 'package:bmitserp/screen/profile/NotificationScreen.dart';
import 'package:bmitserp/screen/profile/new_profileScreen.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HeaderProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrefProvider>(context);
   return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            screen: ChangeNotifierProvider<ProfileUserProvider>(
                create: (BuildContext context) => ProfileUserProvider(),
                child: ProfileScreenActivity()),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
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
                errorBuilder: (context, error, stackTrace) {
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
            IconButton(
                onPressed: () {
                  pushNewScreen(context,
                      screen: NotificationScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
