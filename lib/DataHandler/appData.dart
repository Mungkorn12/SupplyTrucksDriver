import 'package:flutter/cupertino.dart';
import 'package:supply_trucks_driver/Models/address.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation;

  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}