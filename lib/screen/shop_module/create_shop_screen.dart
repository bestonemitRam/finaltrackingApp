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

class CreateShopScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateShopScreenState();
}

class CreateShopScreenState extends State<CreateShopScreen> {
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
    controller.addressController.clear();
    controller.nameController.clear();
    controller.addressController.clear();
    controller.lat.value = 0.0;
    controller.long.value = 0.0;
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.addressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              Obx(() =>
              Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () => controller.pickImage(),
                              child: Text('Upload Image'),
                            ),
                            controller.imageFile.value == null
                                ? SizedBox(height: 20)
                                : SizedBox(),
                            controller.imageFile.value == null
                                ? SizedBox()
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 25.h,
                                    child: Container(
                                      child: Image.file(
                                        File(
                                          controller.imageFile.value!.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.nameController,
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
                                hintText: 'Retailer Name',
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
                              controller: controller.contactController,
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
                              controller: controller.addressController,
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
                                      if (controller.imageFile == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please select Image",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            fontSize: 16.0);
                                      } else {
                                        bool status =
                                            await controller.RegisterRetailer();
                                        if (status)
                                         {
                                          print("kdlfhg $status");
                                          Provider.of<LeaveProvider>(context, listen: false)
                                              .getShopList();
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
