import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/model/distributor_model.dart';
import 'package:bmitserp/screen/distributors/edit_distributors.dart';
import 'package:bmitserp/utils/SingleImageView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DistributorScreenListData extends StatelessWidget {
  final int id;
  final String distributorAvatar;
  final String distributorOrgName;
  final String fullName;
  final String address;
  final String mail;
  final String contact;
  final int isActive;
  final String createdAt;
  final int is_varified;
  final DistributorList distributorList;
  DistributorScreenListData(
      {required this.id,
      required this.distributorAvatar,
      required this.distributorOrgName,
      required this.fullName,
      required this.address,
      required this.mail,
      required this.contact,
      required this.isActive,
      required this.createdAt,
      required this.is_varified,
      required this.distributorList});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                          SingleImageView(APIURL.imageURL + distributorAvatar));
                    },
                    child: Container(
                      width: 15.w,
                      height: 9.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: APIURL.imageURL + distributorAvatar,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: new CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name : ",
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            "$fullName",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
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
                          "Org. Name : ",
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Text(
                            "$distributorOrgName",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: TextStyle(
                                color: HexColor("#036eb7"), fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "Phone No. : ",
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            "$contact",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
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
                          "Email : ",
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "$mail",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: TextStyle(
                                color: HexColor("#036eb7"), fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "State : ",
                    //       maxLines: 1,
                    //       style: TextStyle(color: Colors.white, fontSize: 15),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 2,
                    //       child: Text(
                    //         "$stateName",
                    //         overflow: TextOverflow.ellipsis,
                    //         maxLines: 10,
                    //         style:
                    //             TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "District : ",
                    //       maxLines: 1,
                    //       style: TextStyle(color: Colors.white, fontSize: 15),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 2,
                    //       child: Text(
                    //         "$districtName",
                    //         overflow: TextOverflow.ellipsis,
                    //         maxLines: 10,
                    //         style:
                    //             TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(EditDistributor(distributorList: distributorList));
                    },
                    child: Icon(
                      Icons.edit_square,
                      color: Colors.white,
                    ))
              ],
            ),
            if (is_varified == 1 && address != '')
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address : ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "$address",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style:
                          TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Color getStatus() {
  //   switch (status) {
  //     case "Approved":
  //       return Colors.green;
  //     case "Rejected":
  //       return Colors.redAccent;
  //     case "Pending":
  //       return Colors.orange;
  //     case "Cancelled":
  //       return Colors.red;
  //     default:
  //       return Colors.orange;
  //   }
  // }
}
