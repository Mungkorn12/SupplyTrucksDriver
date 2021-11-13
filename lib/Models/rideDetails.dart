import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDetails
{
  String pickup_address;
  LatLng pickup;
  String ride_request_id;
  String rider_name;
  String rider_phone;

  RideDetails({this.pickup_address, this.pickup, this.ride_request_id, this.rider_name, this.rider_phone});
}