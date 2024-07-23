
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class GeolocatorService{

  Future<Position> getCurrentLocation() async{
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<List<Placemark>> getCurrentAddress(Position position) async{
    return await placemarkFromCoordinates(position.latitude, position.longitude);

  }




  

}