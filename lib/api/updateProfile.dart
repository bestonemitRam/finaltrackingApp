import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateProfiles {
  Future updateProfile(String name, String email, String address, String dob,
      String gender, String phone, File avatar) async {
    var uri = Uri.parse(APIURL.UPDATE_PROFILE);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();



    dynamic response;
    try {
      if (avatar.path != '') 
      {
        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        request.headers.addAll(headers);

        final file = await http.MultipartFile.fromPath('avatar', avatar.path);
      

        request.files.add(file);
        request.fields['full_name'] = name;
        request.fields['mail'] = email;
        request.fields['contact'] = phone;
        request.fields['dob'] = dob;
        request.fields['gender'] = gender;
        request.fields['address'] = address;

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
         

          var out = jsonDecode(response.body);
         

          if (response.statusCode == 201) {
            Fluttertoast.showToast(
                msg: "Profile Updated Successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            Get.back();
            Get.back();
            EasyLoading.dismiss(animation: true);

           
          } else 
          {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "Error !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        } catch (e) {
         
        }

        return Future.error('error');
      } else 
      {
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        response = await http.post(uri, headers: headers, body: {
          'full_name': name,
          'mail': email,
          'contact': phone,
          'dob': dob,
          'gender': gender,
          'address': address,
        });

        final responseData = json.decode(response.body);

      
        if (response.statusCode == 201)
         {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Profile Updated Successfully !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Get.back();
         
        }
         else 
         {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Error !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
