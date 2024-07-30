import 'package:bmitserp/map/map_route.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/shop_module/create_shop_screen.dart';
import 'package:bmitserp/screen/shop_module/shop_list.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShopListingScreen extends StatefulWidget {
  const ShopListingScreen({Key? key}) : super(key: key);

  @override
  State<ShopListingScreen> createState() => _ShopListingScreenState();
}

class _ShopListingScreenState extends State<ShopListingScreen> {
  var init = true;
  late BitmapDescriptor customIcon;

  @override
  void didChangeDependencies() {
    if (init) {
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
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getShopList();

    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    if (leaveData == 200) {}

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
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
              "Retailers List",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.to(RetailerMap(customIcon));
                //Get.to(MapSample());
              },
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
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
                        child: CreateShopScreen(),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    color: Colors.white24,
                    child: Text(
                      "Add New Retailer",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            )
          ],
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
          child: SafeArea(
            child: SingleChildScrollView(
              physics:
                  AlwaysScrollableScrollPhysics(), // Ensure it's always scrollable
              child: Column(
                children: [
              
               ShopList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
