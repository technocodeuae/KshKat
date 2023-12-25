
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MapArgument {
  final String? token;
  final int? numCart;
  final String? userInfo;
  final LocationData? myLocation;
  final Position? myLocationIos;

  MapArgument(this.token,this.numCart,this.userInfo,this.myLocation, this.myLocationIos);
}