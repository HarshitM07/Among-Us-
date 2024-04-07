import 'dart:math';

// Function to calculate the distance between two points using the Haversine formula
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Radius of the earth in kilometers

  // Convert degrees to radians
  double toRadians(double degrees) {
    return degrees * pi / 180;
  }

  // Haversine formula
  double dLat = toRadians(lat2 - lat1);
  double dLon = toRadians(lon2 - lon1);

  double a = pow(sin(dLat / 2), 2) +
      cos(toRadians(lat1)) * cos(toRadians(lat2)) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance in kilometers
}

// Function to check if a destination point is within a specified radius of a source point
bool isWithinRadius(double destLat, double destLon, double sourceLat,
    double sourceLon, double radius) {
  // Calculate the distance between the source and destination points
  double distance = calculateDistance(sourceLat, sourceLon, destLat, destLon);

  // Check if the distance is less than or equal to the specified radius
  return distance <= radius;
}
