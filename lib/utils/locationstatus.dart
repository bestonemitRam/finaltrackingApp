import 'package:geolocator/geolocator.dart';

class LocationStatus {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
 
    if (!serviceEnabled) {
     
      return Future.error(
          'Please enable your location, it seems to be turned off.');
    }


    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
 
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
     
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions. Please give permission and try again.');
    }

   
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

   
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
