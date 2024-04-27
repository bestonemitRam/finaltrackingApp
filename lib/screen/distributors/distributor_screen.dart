


import 'package:bmitserp/map/distributor_map.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/screen/distributors/create_distributor_screen.dart';
import 'package:bmitserp/screen/distributors/distributor_list.dart';

import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DistributorScreen extends StatefulWidget {
  const DistributorScreen({super.key});

  @override
  State<DistributorScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DistributorScreen> {
  var init = true;
  var isVisible = false;
  late BitmapDescriptor customIcon;
  double lat = 00.00;
  double long = 00.00;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();

      init = false;
    }

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/icons/store.png')
        .then((d) {
      customIcon = d;
    });
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getDistributorList();

    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    if (leaveData == 200) {}

    return "Loaded";
  }

  @override
  void initState() {
    super.initState();
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
                "Distributor List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  //Get.to(DistributorMap(customIcon: customIcon));
                  Get.to(MyApps(customIcon, lat, long));
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
                                topRight: Radius.circular(20))),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: CreateDistributor(),
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.white24,
                      child: Text(
                        "Add New Distributor",
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
              onRefresh: () {
                return initialState();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: 
                    [
                      DistributorLists(),
                    ],
                  ),
                ),
              )),
        ));
  }
}

