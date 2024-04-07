import 'package:among_us2/fetures/home/home_screen.dart';
import 'package:among_us2/fetures/join_a_team/join_team.dart';
import 'package:among_us2/fetures/landing/screen/landing_page.dart';
import 'package:among_us2/fetures/verify_email/verify_email_screen.dart';
import 'package:among_us2/firebase_options.dart';
import 'package:among_us2/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
late String GlobalteamName;
Position? location = Position(
    longitude: 0.00,
    latitude: 0.00,
    timestamp: DateTime.now(),
    accuracy: 0.00,
    altitude: 0.00,
    altitudeAccuracy: 0.00,
    heading: 0.00,
    headingAccuracy: 0.00,
    speed: 0.00,
    speedAccuracy: 0.00);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong !!!"),
          );
        } else if (snapshot.hasData) {
          User? user = snapshot.data;
          bool isEmailVerified = user!.emailVerified;

          if (!isEmailVerified) {
            return const VerifyEmail();
          } else {
            return FutureBuilder<bool>(
              future: FirestoreServices().isPlayerRegistered(
                  user.email!), // Pass user's email as parameter
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error checking player registration"),
                  );
                } else {
                  bool isRegistered = snapshot.data ?? false;

                  if (isRegistered) {
                    FirestoreServices().playerTeam(user.email!).then(
                      (value) {
                        return HomeScreen(
                          teamName: value,
                        ); // Navigate to HomePage if registered
                      },
                    );

                    return const JoinTeamScreen();
                  } else {
                    return const JoinTeamScreen(); // Navigate to JoinTeamScreen if not registered
                  }
                }
              },
            );
          }
        } else {
          return LandingPage(); // Show LandingPage if user is not authenticated
        }
      },
    ),
  ));
}
