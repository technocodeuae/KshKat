
import 'package:geocoding/geocoding.dart';

Future<String> getLoc(double? lat,double? lan) async
{

  List<Placemark> placemark;
  try {
     placemark = await placemarkFromCoordinates(lat!, lan!);

  } catch (e) {
    await Future.delayed(Duration(milliseconds: 300));
     placemark = await placemarkFromCoordinates(lat!, lan!);

    try {
      placemark = await placemarkFromCoordinates(lat, lan,localeIdentifier: "en");
    } catch (e) {
    }
  }


  String address= placemark[0].country!+"-"+ placemark[0].name!+"-"+ placemark[0].street!+"-"+placemark[0].locality!+"-"+placemark[0].postalCode!;

  return  address;


}