import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/screen/genrateOrder/order_genrate_ui.dart';
import 'package:bmitserp/screen/genrateOrder/order_list_screen.dart';
import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/edit_retailer.dart';
import 'package:bmitserp/utils/SingleImageView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListUi extends StatelessWidget {
  int? id;
  dynamic retailerName;
  dynamic retailerShopName;
  dynamic retailerAddress;
  dynamic retailerLatitude;
  dynamic retailerLongitude;
  dynamic retailerShopImage;
  dynamic retailerContact;
  int? isVarified;
  dynamic retailer_data;
  ListUi(
      {required this.id,
      required this.retailerName,
      required this.retailerShopName,
      required this.retailerAddress,
      required this.retailerLatitude,
      required this.retailerLongitude,
      required this.retailerShopImage,
      required this.retailerContact,
      required this.isVarified,
      required this.retailer_data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                        SingleImageView(APIURL.imageURL + retailerShopImage));
                  },
                  child: Container(
                    width: 50,
                    height: 60,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: APIURL.imageURL + retailerShopImage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: new CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shop Name : ",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Text(
                              "$retailerShopName",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: HexColor("#036eb7"), fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Owner Name : ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            //  width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "$retailerName",
                              style: TextStyle(
                                  color: HexColor("#036eb7"), fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone No.: ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Text(
                              "$retailerContact",
                              style: TextStyle(
                                  color: HexColor("#036eb7"), fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // if (isVarified == 0)
                //   GestureDetector(
                //       onTap: () {
                //         Get.to(EditRetailer(
                //             id: id,
                //             retailerName: retailerName,
                //             retailerShopName: retailerShopName,
                //             retailerAddress: retailerAddress,
                //             retailerLatitude: retailerLatitude,
                //             retailerLongitude: retailerLongitude,
                //             retailerShopImage: retailerShopImage,
                //             retailerContact: retailerContact,
                //             isVarified: isVarified,
                //             retailer_data: retailer_data));
                //       },
                //       child: Icon(
                //         Icons.edit_square,
                //         color: Colors.white,
                //       ))
              ],
            ),
            if (retailerAddress != "")
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shop Address : ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Container(
                    child: Text(
                      "$retailerAddress",  
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style:
                          TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      elevation: 0,
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: OrderGenerate(id: id!),
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.orange,
                      child: Text(
                        "Create Order",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(OrderListingScreen(id: id!));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.orange,
                      child: Text(
                        "  Order List  ",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Get.to(EditRetailer(
                          id: id,
                          retailerName: retailerName,
                          retailerShopName: retailerShopName,
                          retailerAddress: retailerAddress,
                          retailerLatitude: retailerLatitude,
                          retailerLongitude: retailerLongitude,
                          retailerShopImage: retailerShopImage,
                          retailerContact: retailerContact,
                          isVarified: isVarified,
                          retailer_data: retailer_data));
                    },
                    child: Icon(
                      Icons.edit_square,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 1.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
