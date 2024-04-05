import 'dart:math';

import 'package:graphx/graphx.dart';

bool isWithinRadius(double destinationLat, double destinationLong,
    double sourceLat, double sourceLong, double radius) {
  var R = 6371e3;
  var dLat = deg2rad(destinationLat - sourceLat);
  var dLon = deg2rad(destinationLong - sourceLong);
  var lat1 = deg2rad(sourceLat);
  var lat2 = deg2rad(destinationLat);

  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));

  var d = R * c;

  return d <= radius;
}
