import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supply_trucks_driver/Models/rideDetails.dart';
import 'package:supply_trucks_driver/Notifications/notificationDialog.dart';
import 'package:supply_trucks_driver/configMaps.dart';
import 'package:supply_trucks_driver/main.dart';
import 'dart:io' show Platform;

class PushNotificationService
{
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(context) async
  {
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) async {
      retrieveRideRequestInfo(getRideRequestId(message), context);
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      retrieveRideRequestInfo(getRideRequestId(message), context);
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      retrieveRideRequestInfo(getRideRequestId(message), context);
    });
  }

  Future<String> getToken() async
  {
    String token = await firebaseMessaging.getToken();
    print("This is token :: ");
    print(token);
    driversRef.child(currentfirebaseUser.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");
  }

  String getRideRequestId(RemoteMessage message)
  {
    String rideRequestId = "";
    if(Platform.isAndroid)
    {
      rideRequestId = message.data['ride_request_id'];
    }
    else
      {
        rideRequestId = message.data['ride_request_id'];
      }

    return rideRequestId;
  }
  
  void retrieveRideRequestInfo(String rideRequestId, BuildContext context)
  {
    newRequestRef.child(rideRequestId).once().then((DataSnapshot dataSnapShot)
    {
      if(dataSnapShot.value != null)
      {
        double pickUpLocationLat = double.parse(dataSnapShot.value['pickup']['latitude'].toString());
        double pickUpLocationLng = double.parse(dataSnapShot.value['pickup']['longitude'].toString());
        String pickUpAddress = dataSnapShot.value['pickup_address'].toString();

        String rider_name = dataSnapShot.value["rider_name"];
        String rider_phone = dataSnapShot.value["rider_phone"];


        RideDetails rideDetails = RideDetails();
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickUpAddress;
        rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        rideDetails.rider_name = rider_name;
        rideDetails.rider_phone = rider_phone;

        print("Information :: ");
        print(rideDetails.pickup_address);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(rideDetails: rideDetails,),
        );
      }
    });
  }
}