import 'dart:async';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/model/distributor_model.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditDistributor extends StatefulWidget {
  final DistributorList distributorList;
  EditDistributor({required this.distributorList});
  @override
  State<StatefulWidget> createState() => CreateShopScreenState();
}

class CreateShopScreenState extends State<EditDistributor> {
  final RetailerController controller = Get.put(RetailerController());

  final _form = GlobalKey<FormState>();
  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  var fileList = [];

  @override
  void initState() {
    controller.disNameController.text = widget.distributorList.name ?? "";
    controller.disemailController.text = widget.distributorList.mail ?? "";
    controller.discontactController.text =
        widget.distributorList.contactNumber ?? "";
    controller.disgstNumberController.text = widget.distributorList.gstNo ?? "";
    controller.disOrgNameController.text =
        widget.distributorList.distributorOrgName ?? "";
    controller.ditributorData.text =
        widget.distributorList.distributor_data ?? "";
    controller.lat.value =
        double.parse(widget.distributorList.distributorLatitude);
    controller.long.value =
        double.parse(widget.distributorList.distributorLongitude);
    controller.distributorProfile.value = null;
    controller.cancelCheque.value = null;
    controller.pancardImage.value = null;
    controller.aadhImagefback.value = null;
    controller.aadhImagefront.value = null;
    controller.fileList.clear();
    controller.fileList.value = [];

    fileList = widget.distributorList.appointmentForm.split(',');
    print("fileList ${widget.distributorList.appointmentForm}  ${fileList[0]}");

    super.initState();
  }

  // @override
  // void didChangeDependencies()
  //  {
  //   final leaveData = Provider.of<LeaveProvider>(context, listen: true);
  //   final distributor = leaveData.distributor;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Shop',
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
              Obx(() => Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () => controller.pickDisImage(),
                              child: Text('Distributor Profile'),
                            ),
                            controller.distributorProfile.value == null
                                ? SizedBox(height: 20)
                                : SizedBox(),
                            controller.distributorProfile.value == null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 25.h,
                                    child: Container(
                                      child: Image.network(
                                        APIURL.imageURL +
                                            widget.distributorList
                                                .distributorAvatar,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/dummy_avatar.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 25.h,
                                    child: Container(
                                      child: Image.file(
                                        File(
                                          controller
                                              .distributorProfile.value!.path,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.disOrgNameController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Distributor Organization Name',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.disNameController,
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Distributor Name',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.discontactController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              cursorColor: Colors.white,
                              maxLength: 10,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: 'Phone No.',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.disemailController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an email';
                                }

                                bool emailValid =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value.trim());
                                if (!emailValid) {
                                  return 'Please enter a valid email';
                                }
                                return null; // Return null if the input is valid
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: ' Email',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.disgstNumberController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              // validator: (value) {
                              //   if (!validateField(value!)) {
                              //     return "Empty Field";
                              //   }

                              //   return null;
                              // },
                              cursorColor: Colors.white,
                              maxLength: 16,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: ' GST Number',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(Icons.account_balance,
                                    color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.ditributorData,
                              keyboardType: TextInputType.streetAddress,
                              style: TextStyle(color: Colors.white),
                              maxLines: 3,
                              readOnly: true,
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Current Address',
                                hintStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(Icons.location_on,
                                    color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "Add Documents",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: InkWell(
                                    onTap: () {
                                      controller.cancelchequeDisImage();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child: controller.cancelCheque.value ==
                                              null
                                          ? widget.distributorList
                                                      .cancelChequeImage !=
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            APIURL.imageURL +
                                                                widget
                                                                    .distributorList
                                                                    .cancelChequeImage,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Update Cancel Cheque",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Add Cancel Cheque",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 10.h,
                                              child: Container(
                                                child: Image.file(
                                                  File(
                                                    controller.cancelCheque
                                                        .value!.path,
                                                  ),
                                                  fit: BoxFit.fill,
                                                  // Determines how the image should be inscribed into the box.
                                                  width:
                                                      200, // Optional. Width of the image.
                                                  height:
                                                      200, // Optional. Height of the image.
                                                  alignment: Alignment
                                                      .center, // Optional. Alignment of the image within its parent widget.
                                                  scale:
                                                      1.0, // Optional. Scale factor of the image. Default is 1.0.
                                                  repeat: ImageRepeat
                                                      .noRepeat, // Optional. How the image should be repeated if it doesn't fill its box. Default is ImageRepeat.noRepeat.
                                                  filterQuality: FilterQuality
                                                      .high, // Optional. Quality level to be used when scaling the image. Default is FilterQuality.low.
                                                  semanticLabel:
                                                      'AadhImage', // Optional. Semantic description for the image.
                                                  gaplessPlayback: false,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: InkWell(
                                    onTap: () {
                                      controller.pancard();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child: controller.pancardImage.value ==
                                              null
                                          ? widget.distributorList
                                                      .pancardImage !=
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            APIURL.imageURL +
                                                                widget
                                                                    .distributorList
                                                                    .pancardImage,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Update Pan Card ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Add Pan Card ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ))
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 10.h,
                                              child: Container(
                                                child: Image.file(
                                                  File(
                                                    controller.pancardImage
                                                        .value!.path,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: InkWell(
                                    onTap: () {
                                      controller.picAadharfront();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child: controller.aadhImagefront.value ==
                                              null
                                          ? widget.distributorList
                                                      .aadharcardImageFront !=
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            APIURL.imageURL +
                                                                widget
                                                                    .distributorList
                                                                    .aadharcardImageFront,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Add Aadhar card front",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Add Aadhar card front",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 10.h,
                                              child: Container(
                                                child: Image.file(
                                                  File(
                                                    controller.aadhImagefront
                                                        .value!.path,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: InkWell(
                                    onTap: () {
                                      controller.picAadharback();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child: controller.aadhImagefback.value ==
                                              null
                                          ? widget.distributorList
                                                      .aadharcardImageBack !=
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            APIURL.imageURL +
                                                                widget
                                                                    .distributorList
                                                                    .aadharcardImageBack,
                                                          ),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Update Aadhar card back",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Add Aadhar card back",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 10.h,
                                              child: Container(
                                                child: Image.file(
                                                  File(
                                                    controller.aadhImagefback
                                                        .value!.path,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "Update Appointment Form",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.addDocument();
                              },
                              child: Card(
                                  shape: CircleBorder(),
                                  color: Colors.white54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            controller.fileList.isNotEmpty
                                ? ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: controller.fileList.length,
                                    itemBuilder: (context, index) {
                                      final file = controller.fileList[index];
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Card(
                                          shape: ButtonBorder(),
                                          elevation: 0,
                                          color: Colors.white12,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 15.h,
                                            child: Container(
                                              child: Image.file(
                                                File(
                                                  file.path!,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: fileList.length,
                                    itemBuilder: (context, index) {
                                      final file = fileList[index];

                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Card(
                                          shape: ButtonBorder(),
                                          elevation: 0,
                                          color: Colors.white12,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 15.h,
                                            child: Container(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    APIURL.imageURL + file,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            new CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            gaps(20),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 5),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: HexColor("#036eb7"),
                                    padding: EdgeInsets.zero,
                                    shape: ButtonBorder(),
                                  ),
                                  onPressed: () async {
                                    bool status =
                                        await controller.editDistributor(widget
                                            .distributorList.id
                                            .toString());  if (status) {
                                      Provider.of<LeaveProvider>(context,
                                              listen: false)
                                          .getDistributorList();
                                      Get.back();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
