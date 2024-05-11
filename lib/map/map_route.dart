import 'dart:async';
import 'dart:ffi';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:bmitserp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RetailerMap extends StatelessWidget {
  final BitmapDescriptor customIcon;

  RetailerMap(this.customIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 19, 16, 42),
          title: Text('Shops Lists'),
        ),
        body: MapScreen(
          customIcon: customIcon,
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final BitmapDescriptor customIcon;

  const MapScreen({
    Key? key,
    required this.customIcon,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  double cameraBearing = 30;
  double cameraZoom = 12;
  double cameraTilt = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final shops = leaveData.shoplist;
    for (int i = 0; i < shops.length; i++) {
      setState(() {
        markers.add(
          Marker(
            icon: widget.customIcon,
            markerId: MarkerId(shops[i].toString()),
            position: LatLng(double.parse(shops[i].retailerLatitude),
                double.parse(shops[i].retailerLongitude)),
            infoWindow: InfoWindow(
                snippet: shops[i].retailerAddress.toString(),
                title:
                    "${shops[i].retailerName + ", " + shops[i].retailerShopName}"),
          ),
        );
      });
    }
    return GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        circles: Set(),
        myLocationEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference(10, 20),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(28.5156935, 77.3770976),
          zoom: cameraZoom,
          tilt: cameraTilt,
          bearing: cameraBearing,
        ),
        markers: Set.from(markers));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
