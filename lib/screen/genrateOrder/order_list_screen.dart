import 'package:bmitserp/map/map_route.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/provider/productprovider.dart';
import 'package:bmitserp/screen/genrateOrder/order_list.dart';
import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/list_ui.dart';
import 'package:bmitserp/screen/shop_module/shop_list.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OrderListingScreen extends StatefulWidget {
  final int id;
  const OrderListingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<OrderListingScreen> createState() => _OrderListingScreenState();
}

class _OrderListingScreenState extends State<OrderListingScreen> {
  var init = true;
  late BitmapDescriptor customIcon;

  @override
  void didChangeDependencies() {
    if (init) 
    {
      initialState();
      init = false;
    }
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/icons/shop.png')
        .then((d) {
      customIcon = d;
    });
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider = Provider.of<ProductProvider>(context, listen: false);
    final leaveData = await leaveProvider.getOrderList(widget.id);
    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    print("ldkgj  ${leaveData.result}");

    if (leaveData == 200) {}

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<ProductProvider>(context, listen: true);
    final order = leaveData.orderlist;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
          title: Center(
            child: Text(
              "Order List",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: Colors.white,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () async {
            await initialState();
          },
          child: order.isNotEmpty
              ? ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  primary: false,
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: order.length,
                  itemBuilder: (ctx, i) {
                    final item = order[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: OrderList(item: item, retailer_id: widget.id),
                    );
                  })
              : Center(
                  child: Container(
                    child: Text(
                      "Sorry ! Don't have a order ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
