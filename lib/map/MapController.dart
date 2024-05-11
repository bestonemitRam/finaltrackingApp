import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final markers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
 
    addMarkers();

    


    
  }

  void addMarkers()
   {
    markers.addAll([
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(22.3029, 70.8022), // Marker 1 position (San Francisco)
        infoWindow: InfoWindow(title: 'Marker 1'), // Info window
      ),
      Marker(
       
        markerId: MarkerId('marker2'),
        position: LatLng(22.3069, 70.8032), // Marker 2 position
        infoWindow: InfoWindow(title: 'Marker 2'), // Info window
      ),

      Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(22.3049, 70.8022), // Marker 2 position
        infoWindow: InfoWindow(title: 'Marker 2'), // Info window
      ),
     
    ]);
  
  }
}
