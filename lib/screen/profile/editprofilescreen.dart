import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/api/app_strings.dart';
import 'package:bmitserp/api/updateProfile.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:bmitserp/provider/profileprovider.dart';
import 'package:hexcolor/hexcolor.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/editprofile';

  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  int genderIndex = 0;

  bool isLoading = false;

  final _form = GlobalKey<FormState>();

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _form.currentState?.dispose();
    super.dispose();
  }

  String getGender() {
    var gender = '';
    switch (genderIndex) {
      case 0:
        gender = 'Male';
        break;
      case 1:
        gender = 'Female';
        break;
      case 2:
        gender = 'Others';
        break;
    }

    return gender;
  }

  void validateValue() async {
    final value = _form.currentState!.validate();

    if (value) {
      isLoading = true;
      setState(() {
        EasyLoading.show(
            status: "Changing", maskType: EasyLoadingMaskType.black);
      });

      UpdateProfiles updateProfiles = UpdateProfiles();
      updateProfiles.updateProfile(
          _nameController.text,
          _emailController.text,
          _addressController.text,
          _dobController.text,
          getGender(),
          _phoneController.text,
          File(imagefiles!.path));
    }
  }

  var initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      _nameController.text = Apphelper.USER_NAME;
      _emailController.text = Apphelper.USER_EMAIL;
      _phoneController.text = Apphelper.USER_CONTACT;
      _dobController.text = Apphelper.USER_DOB;

      switch (Apphelper.USER_GENDAR.toLowerCase()) {
        case 'Male':
          genderIndex = 0;
          break;
        case 'Female':
          genderIndex = 1;
          break;
        case 'Others':
          genderIndex = 2;
          break;
        default:
          genderIndex = 0;
          break;
      }
      setState(() {});
      initial = false;
    }
    super.didChangeDependencies();
  }

  final ImagePicker imgpicker = ImagePicker();
  XFile? imagefiles;

  openImages() async {
    try {
      final XFile? image =
          await imgpicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagefiles = image;
        setState(() {});
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'EditProfile',
              style: TextStyle(color: Colors.white),
            ),
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: HexColor("#036eb7"),
                    shape: ButtonBorder(),
                    fixedSize: Size(double.maxFinite, 55)),
                onPressed: () {
                  if (imagefiles != null) {
                    validateValue();
                  } else {
                    showToast("Please pic profile image");
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 6.h,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 5.5.h,
                      backgroundImage: imagefiles != null
                          ? FileImage(File(imagefiles!.path))
                          : Apphelper.USER_AVATAR != "USER_AVATAR"
                              ? NetworkImage(APIURL.imageURL +
                                  Apphelper.USER_AVATAR.toString())
                              : AssetImage('assets/images/dummy_avatar.png')
                                  as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            openImages();
                          },
                          child: CircleAvatar(
                            radius: 2.h,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
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
                              hintText: 'Fullname',
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (!validateField(value!)) {
                                return "Empty Field";
                              }

                              return null;
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                            controller: _addressController,
                            keyboardType: TextInputType.streetAddress,
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (!validateField(value!)) {
                                return "Empty Field";
                              }

                              return null;
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.location_on, color: Colors.white),
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
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (!validateField(value!)) {
                                return "Empty Field";
                              }

                              return null;
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon: Icon(Icons.phone_android,
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
                            controller: _dobController,
                            validator: (value) {
                              if (!validateField(value!)) {
                                return "Empty Field";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Date of Birth',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon: Icon(Icons.calendar_month_sharp,
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
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  _dobController.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ToggleSwitch(
                                  borderWidth: 1,
                                  borderColor: [Colors.white12],
                                  dividerColor: Colors.white12,
                                  activeBgColor: const [Colors.white12],
                                  activeFgColor: Colors.white,
                                  inactiveFgColor: Colors.white,
                                  inactiveBgColor: Colors.transparent,
                                  minWidth: 100,
                                  minHeight: 45,
                                  initialLabelIndex: genderIndex,
                                  totalSwitches: 3,
                                  onToggle: (index) {
                                    genderIndex = index!;
                                  },
                                  labels: const ['Male', 'Female', 'Other'],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
