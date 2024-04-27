import 'dart:convert';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:bmitserp/data/source/network/model/leavetype/LeaveType.dart';
import 'package:bmitserp/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:bmitserp/data/source/network/model/leavetypedetail/LeaveTypeDetail.dart';
import 'package:bmitserp/data/source/network/model/leavetypedetail/Leavetypedetailreponse.dart';
import 'package:bmitserp/data/source/network/model/retailer/reatailer_model.dart';
import 'package:bmitserp/main.dart';
import 'package:bmitserp/model/LeaveDetail.dart';
import 'package:bmitserp/model/advance_order.dart';
import 'package:bmitserp/model/advance_order.dart';
import 'package:bmitserp/model/distributor_data_list.dart';
import 'package:bmitserp/model/distributor_model.dart';
import 'package:bmitserp/model/distributor_state_model.dart';
import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/model/order_list.dart';
import 'package:bmitserp/model/product_model.dart';
import 'package:bmitserp/model/select_leave_model.dart';
import 'package:bmitserp/model/shop.dart';

import 'package:bmitserp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class ProductProvider with ChangeNotifier {
  Future<ProdectModel> getProductList() async {
    print("check get all shop list data ");
    var uri = Uri.parse(APIURL.PRODUCT_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http
            .get(uri, headers: headers)
            .timeout(Duration(seconds: 50));
        final responseData = json.decode(response.body);

        final responseJson = ProdectModel.fromJson(responseData);

        if (response.statusCode == 200) {
          debugPrint(responseData.toString());

          String datas = jsonEncode(ProdectModel.fromJson(responseData));
          sharedPref.setString('productList', datas);

          makeProduct(responseJson!);
          EasyLoading.dismiss(animation: true);

          return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          var errorMessage = responseData['message'];

          String? dataModelJson = sharedPref.getString('productList');

          if (dataModelJson != null) {
            var userMap = jsonDecode(dataModelJson!);
            final responseJson = ProdectModel.fromJson(userMap);
            makeProduct(responseJson!);
          }

          return responseJson;
        }
      } catch (error) {
        EasyLoading.dismiss(animation: true);
        throw error;
      }
    } else {
      String? dataModelJson = sharedPref.getString('productList');

      if (dataModelJson != null) {
        var userMap = jsonDecode(dataModelJson!);
        final responseJson = ProdectModel.fromJson(userMap);
        makeProduct(responseJson!);
      }

      EasyLoading.dismiss(animation: true);
      Fluttertoast.showToast(
          msg: "Please check your internet connections!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  final List<ProductList> _productlist = [];

  List<ProductList> get productlist {
    return [..._productlist];
  }

  void makeProduct(ProdectModel data) {
    _productlist.clear();
    print("kjdfgkj  ${data.result}");

    for (var shop in data.result!) {
      _productlist.add(shop);
    }

    notifyListeners();
  }

  ////////////////////////////////////////////////////////////  OrderList /////////////////////////////////////////

  Future<OrderListModel> getOrderList(int retailer_id) async {
    var uri = Uri.parse(APIURL.ORDER_LIST + "${retailer_id}");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http.get(uri, headers: headers);
        final responseData = json.decode(response.body);

        print("Check leave data ${responseData}");
        final responseJson = OrderListModel.fromJson(responseData);
        if (response.statusCode == 200) {
          debugPrint(responseData.toString());

          makeOderList(responseJson.result);
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
    } else {
      EasyLoading.dismiss(animation: true);
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

  void makeOderList(List<OderListData>? data) {
    _orderlist.clear();

    for (var order in data!.reversed) {
      _orderlist.add(order);
    }

    notifyListeners();
  }

  final List<OderListData> _orderlist = [];

  List<OderListData> get orderlist {
    return [..._orderlist];
  }

////////////////////////////////////////////////////////////// Advance Order //////////////////////////////////////////////////////////
  Future<AdvanceOrder> getAdvanceList() async {
    var uri = Uri.parse(APIURL.ADVANCE_ORDER);

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
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http
            .get(uri, headers: headers)
            .timeout(Duration(seconds: 50));
        final responseData = json.decode(response.body);

        final responseJson = AdvanceOrder.fromJson(responseData);

      

        if (response.statusCode == 200) {
          debugPrint(responseData.toString());

          String datas = jsonEncode(AdvanceOrder.fromJson(responseData));
          sharedPref.setString('productList', datas);

          makeAdvanceOrderList(responseJson);
          EasyLoading.dismiss(animation: true);

          return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          var errorMessage = responseData['message'];

          String? dataModelJson = sharedPref.getString('productList');

          if (dataModelJson != null) {
            var userMap = jsonDecode(dataModelJson!);
            final responseJson = ProdectModel.fromJson(userMap);
            makeProduct(responseJson!);
          }

          return responseJson;
        }
      } catch (error) {
        EasyLoading.dismiss(animation: true);
        throw error;
      }
    } else {
      String? dataModelJson = sharedPref.getString('productList');

      if (dataModelJson != null) {
        var userMap = jsonDecode(dataModelJson!);
        final responseJson = ProdectModel.fromJson(userMap);
        makeProduct(responseJson!);
      }

      EasyLoading.dismiss(animation: true);
      Fluttertoast.showToast(
          msg: "Please check your internet connections!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  final List<AdvanceDataList> _advanceDataLists = [];

  List<AdvanceDataList> get advanceDataList {
    return [..._advanceDataLists];
  }

  void makeAdvanceOrderList(AdvanceOrder responseJson) {
    _advanceDataLists.clear();

    for (var advancelist in responseJson.result!) {
      _advanceDataLists.add(advancelist);
    }

    notifyListeners();
  }
}
