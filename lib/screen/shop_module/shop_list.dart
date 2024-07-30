import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/data_not_found.dart';
import 'package:bmitserp/screen/shop_module/list_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final shops = leaveData.shoplist;
    if (shops.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: shops.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListUi(
                  id: shops[i].id,
                  retailerName: shops[i].retailerName,
                  retailerShopName: shops[i].retailerShopName,
                  retailerAddress: shops[i].retailerAddress,
                  retailerLatitude: shops[i].retailerLatitude,
                  retailerLongitude: shops[i].retailerLongitude,
                  retailerShopImage: shops[i].retailerShopImage,
                  retailerContact: shops[i].retailer_mobile_number,
                  isVarified: shops[i].isVarified,
                  retailer_data: shops[i].retailer_data),
            );
          });
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Center(
          child: Container(
              child: NoDataFoundErrorScreens(
            height: 50.0.h,
            title: "No Data Found",
          )),
        ),
      );
    }
  }
}
