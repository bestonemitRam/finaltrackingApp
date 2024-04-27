import 'package:bmitserp/map/google_map_screen.dart';
import 'package:bmitserp/map/map_route.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/profileUserProvider.dart';
import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/screen/distributors/distributor_screen.dart';
import 'package:bmitserp/screen/genrateOrder/order_genrate_ui.dart';
import 'package:bmitserp/screen/inventory_module/inventory_list.dart';
import 'package:bmitserp/screen/profile/changepasswordscreen.dart';
import 'package:bmitserp/screen/profile/holidayscreen.dart';
import 'package:bmitserp/screen/profile/leavecalendarscreen.dart';
import 'package:bmitserp/screen/profile/new_profileScreen.dart';
import 'package:bmitserp/screen/shop_module/shop_listing_screen.dart';
import 'package:bmitserp/screen/tadascreen/TadaScreen.dart';
import 'package:bmitserp/widget/headerprofile.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:bmitserp/widget/task_status/task_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:bmitserp/widget/morescreen/services.dart';
import 'package:bmitserp/widget/morescreen/securitycheck.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderProfile(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Services',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                Services(
                    'Profile',
                    Icons.person,
                    ChangeNotifierProvider<ProfileUserProvider>(
                        create: (BuildContext context) => ProfileUserProvider(),
                        child: ProfileScreenActivity())),

                Services('Retailers', Icons.shop, ShopListingScreen()),

                 Services('My Inventory', Icons.inventory, InventoryReport()),

                Services('Distributors', Icons.directions_boat_filled_rounded,
                    DistributorScreen()),

                // Services('My Task', Icons.group_work_sharp, TaskStatusScreen()),
                // Services('TA / DA', Icons.money, TadaScreen()),
                // Services('Holiday', Icons.calendar_month, HolidayScreen()),

                //Services('Leave Calendar', Icons.calendar_month_outlined,LeaveCalendarScreen()),

                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 5),
                  child: Text(
                    "Additional",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // Services('Change Password', Icons.password, ChangePasswordScreen()),
                // Services('Terms and Conditions', Icons.rule,
                // AboutScreen('terms-and-conditions')),

                Services(
                    'Privacy Policy', Icons.policy, ChangePasswordScreen()),

                // SecurityCheck('Security Check', Icons.security, ''),

                Services('Log Out', Icons.logout, ChangePasswordScreen()),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
