import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supply_trucks_driver/Models/allUsers.dart';
import 'package:supply_trucks_driver/Models/drivers.dart';

String mapKey = "AIzaSyCz8y5PvYUujiEfGPL_g_9qarrS5DOe1zs";

User firebaseUser;

Users userCurrentInfo;

User currentfirebaseUser;

StreamSubscription<Position> homeTabPageStreamSubscription;

StreamSubscription<Position> rideStreamSubscription;

Position currentPosition;

Drivers driversInformation;