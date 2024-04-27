import 'dart:io';

import 'package:bmitserp/data/source/network/controller/retailer_controller.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/radialDecoration.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
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

class CreateDistributor extends StatefulWidget 
{
  @override
  State<StatefulWidget> createState() => CreateShopScreenState();
}

class CreateShopScreenState extends State<CreateDistributor> {
  final RetailerController controller = Get.put(RetailerController());

  final _form = GlobalKey<FormState>();
  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    controller.disNameController.clear();
    controller.disemailController.clear();
    controller.discontactController.clear();
    controller.disgstNumberController.clear();
    controller.disOrgNameController.clear();
    controller.ditributorData.clear();
    controller.lat.value = 0.0;
    controller.long.value = 0.0;
    controller.distributorProfile.value = null;
    controller.cancelCheque.value = null;
    controller.pancardImage.value = null;
    controller.aadhImagefback.value = null;
    controller.aadhImagefront.value = null;
    controller.fileList.clear();
    controller.fileList.value = [];
  super.initState();
  }

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
                                ? SizedBox()
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
                                      MediaQuery.of(context).size.width / .6.w,
                                  child: InkWell(
                                    onTap: () {
                                      controller.cancelchequeDisImage();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child:
                                          controller.cancelCheque.value == null
                                              ? Container(
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
                                                        "Cancel Cheque Image",
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
                                      MediaQuery.of(context).size.width / .6.w,
                                  child: InkWell(
                                    onTap: () {
                                      controller.pancard();
                                    },
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child:
                                          controller.pancardImage.value == null
                                              ? Container(
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
                                                        "Pan Card Image",
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
                                      MediaQuery.of(context).size.width / .6.w,
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
                                          ? Container(
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
                                                    "Aadhar card front",
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
                                      MediaQuery.of(context).size.width / .6.w,
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
                                          ? Container(
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
                                                    "Aadhar card back",
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
                                  "Add Appointment Form",
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
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (controller.fileList.isNotEmpty)
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: controller.fileList.length,
                                itemBuilder: (context, index) {
                                  final file = controller.fileList[index];

                                  return Container(
                                    width: MediaQuery.of(context).size.width /
                                        .6.w,
                                    child: Card(
                                      shape: ButtonBorder(),
                                      elevation: 0,
                                      color: Colors.white12,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                    if (_form.currentState!.validate()) {
                                      if (controller.distributorProfile.value ==
                                          null) {
                                        Fluttertoast.showToast(
                                            msg: "Please select profile",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else if (controller.fileList.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please select Appointment",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else {
                                        bool status = await controller
                                            .createrDistributor();
                                        print("jksdghfjh ${status}");
                                        if (status) {
                                          print("dsdsd ${status}");
                                          Provider.of<LeaveProvider>(context,
                                                  listen: false)
                                              .getDistributorList();
                                          Get.back();
                                        }
                                      }
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
