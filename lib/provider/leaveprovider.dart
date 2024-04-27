import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:bmitserp/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:bmitserp/data/source/network/model/leavetypedetail/Leavetypedetailreponse.dart';
import 'package:bmitserp/data/source/network/model/retailer/reatailer_model.dart';
import 'package:bmitserp/model/LeaveDetail.dart';
import 'package:bmitserp/model/distributor_model.dart';
import 'package:bmitserp/model/distributor_state_model.dart';
import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/model/select_leave_model.dart';
import 'package:bmitserp/model/shop.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LeaveProvider with ChangeNotifier {
  final List<Leave> _leaveList = [];
  final List<Leave> _selectleaveList = [];
  final List<LeaveDetail> _leaveDetailList = [];

  var _selectedMonth = 0;
  var _selectedType = 0;

  int get selectedMonth {
    return _selectedMonth;
  }

  void setMonth(int value) {
    _selectedMonth = value;
  }

  int get selectedType {
    return _selectedType;
  }

  void setType(int value) {
    _selectedType = value;
  }

  List<Leave> get leaveList {
    return [..._leaveList];
  }

  List<Leave> get selectleaveList {
    return [..._selectleaveList];
  }

  List<LeaveDetail> get leaveDetailList {
    return [..._leaveDetailList];
  }

  Future<Leavetyperesponse> getLeaveType() async {
   
    var uri = Uri.parse(APIURL.BUUCKET_LEAVE);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
  
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        final response = await http.get(uri, headers: headers);

        final responseData = json.decode(response.body);

       

        if (response.statusCode == 200) {
        

          final responseJson = Leavetyperesponse.fromJson(responseData);
          makeLeaveList(responseJson.result!);

          return responseJson;
        } else {
          var errorMessage = responseData['message'];
          throw errorMessage;
        }
      } catch (error) {
        throw error;
      }
    } else {
      var errorMessage = "Please check your internet connection! ";
      Fluttertoast.showToast(
          msg: "Please check your internet connections!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      throw errorMessage;
    }
  }

  void makeLeaveList(Data data) {
    _leaveList.clear();

    for (var leave in data.leavesData!) {
      _leaveList.add(Leave(
          id: int.parse('0'),
          name: leave.leaveTypeName!,
          allocated: int.parse(leave.taken.toString() ?? "0"),
          total: int.parse(leave.available.toString() ?? "0"),
          status: true,
          isEarlyLeave: true));
    }

    notifyListeners();
  }

  Future<SelectLeaveTypeModel> selectLeaveType() async {
    var uri = Uri.parse(APIURL.SELECT_LEAVE_API);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
  
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

   

      if (response.statusCode == 200) {
      

        final responseJson = SelectLeaveTypeModel.fromJson(responseData);
        selectLeaveList(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void selectLeaveList(Result data) {
    _selectleaveList.clear();

    for (var leave in data.leaveTypes!) {
      _selectleaveList.add(Leave(
          id: int.parse(leave.id.toString() ?? '0'),
          name: leave.leaveTypeName!,
          allocated: int.parse("0"),
          total: int.parse("0"),
          status: true,
          isEarlyLeave: true));
    }

    notifyListeners();
  }

  Future<Leavetypedetailreponse> getLeaveTypeDetail() async {
    var uri;

    if (_selectedType == 0) {
      uri = Uri.parse(APIURL.LEAVE_LIST_DETAILS_API +
          "fetchType=${_selectedMonth == 0 ? "year" : "month"}");
    } else {
      uri = Uri.parse(APIURL.LEAVE_LIST_DETAILS_API +
          "fetchType=${_selectedMonth == 0 ? "year" : "month"}&leaveTypeID=${_selectedType}");
    }

  
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

   
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
     
      final responseJson = Leavetypedetailreponse.fromJson(responseData);

      if (response.statusCode == 200) {
       
       
        makeLeaveTypeList(responseJson!);

        return responseJson;
      } else {
        makeLeaveTypeListempty();
        var errorMessage = responseData['message'];

        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void makeLeaveTypeList(Leavetypedetailreponse leaveList)
   {
    _leaveDetailList.clear();
    for (var leave in leaveList.result!) 
    {
      _leaveDetailList.add(LeaveDetail(
          id: 1,
          name: leave.leaveTypeName!,
          leave_from: leave.leaveFrom!,
          leave_to: leave.leaveTo!,
          requested_date: '',
          authorization: leave.status!,
          status: leave.status!));
    }

    notifyListeners();
  }


   void makeLeaveTypeListempty() {
    _leaveDetailList.clear();
   
 _leaveDetailList.isEmpty;
    

    notifyListeners();
  }

  Future<IssueLeaveResponse> issueLeave(
      String from, String to, String reason, int leaveId) async {
    var uri = Uri.parse(APIURL.LEAVE_REQUEST_API);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
  
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await http.post(uri, headers: headers, body: {
        'leave_from': from,
        'leave_to': to,
        'leave_type_id': leaveId.toString(),
        'reason': reason,
      });

      final responseData = json.decode(response.body);

   
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);
      return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error)
     {
     
      throw error;
    }
  }

  Future<IssueLeaveResponse> cancelLeave(int leaveId) async {
    var uri = Uri.parse(Constant.CANCEL_LEAVE + "/$leaveId");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);

       
        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
     
      throw error;
    }
  }

  final List<Shop> _shoplist = [];

  List<Shop> get shoplist {
    return [..._shoplist];
  }

  Future<RetailerModel> getShopList() async {
    var uri = Uri.parse(APIURL.GET_RETAILER_LIST);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
  
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

  
    try {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

    
      final responseJson = RetailerModel.fromJson(responseData);
      if (response.statusCode == 200)
       {
        makeShopList(responseJson.result!);
        EasyLoading.dismiss(animation: true);

        return responseJson;
      } 
      else
       {
        EasyLoading.dismiss(animation: true);
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      EasyLoading.dismiss(animation: true);
      throw error;
    }
    //  }
    // else {
    //   EasyLoading.dismiss(animation: true);
    //   Fluttertoast.showToast(
    //       msg: "Please check your internet connections!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       fontSize: 16.0);
    //   var errorMessage = "Please check your internet connection! ";
    //   throw errorMessage;
    // }
  }

  void makeShopList(ResultData data) {
    _shoplist.clear();

    for (var shop in data.retailersList!.reversed) {
      _shoplist.add(Shop(
          id: int.parse(shop.id.toString() ?? '0'),
          retailerName: shop.retailerName ?? " ",
          retailerShopName: shop.retailerShopName ?? "",
          retailerAddress: shop.retailerAddress ?? "",
          retailerLatitude: shop.retailerLatitude ?? " ",
          retailerLongitude: shop.retailerLongitude ?? " ",
          retailerShopImage: shop.retailerShopImage ?? " ",
          retailer_mobile_number: shop.retailer_mobile_number ?? "",
          isVarified: shop.isVarified ?? 0!,
          retailer_data: shop.retailer_data ?? ""));
    }

    notifyListeners();
  }

  final List<DistributorList> _distributor = [];
  final List<HomePagedata> _homePagedata = [];

  List<HomePagedata> get getHomeData {
    return [..._homePagedata];
  }

  List<DistributorList> get distributor {
    return [..._distributor];
  }

  void makeDistributorList(DistributorData data) {
  
    _distributor.clear();

    for (var distributor in data.distributorList!.reversed!) {
      _distributor.add(distributor );
    }

    notifyListeners();
  }

  void stateList(HomePagedata data) {
    _homePagedata.clear();

    _homePagedata.add(HomePagedata(
        totalDistributors: data.totalDistributors,
        totalRetailers: data.totalRetailers));
    notifyListeners();
  }

  Future<DistributorModel> getDistributorList() async {
   
    var uri = Uri.parse(APIURL.DISTRIBUTOR_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
  
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      final responseJson = DistributorModel.fromJson(responseData);
      if (response.statusCode == 200) {
       
        makeDistributorList(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<HomePageModel> getStateList() async {
    var uri = Uri.parse(APIURL.GET_ALL_RETAILER_AND_DISTRI);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

     
      final responseJson = HomePageModel.fromJson(responseData);
      if (response.statusCode == 200) {
       
        stateList(responseJson.result!);
        EasyLoading.dismiss(animation: true);

        return responseJson;
      } else {
        EasyLoading.dismiss(animation: true);
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      EasyLoading.dismiss(animation: true);
      throw error;
    }
  }
}
