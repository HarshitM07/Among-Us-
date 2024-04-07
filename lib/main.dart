import 'package:among_us2/fetures/death_screen/dead_screen.dart';
import 'package:among_us2/fetures/join_a_team/join_team.dart';
import 'package:among_us2/fetures/landing/screen/landing_page.dart';
import 'package:among_us2/fetures/verify_email/verify_email_screen.dart';
import 'package:among_us2/fetures/waiting_area/wating_screen.dart';
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
              future: FirestoreServices().isPlayerRegistered(user.email!),
              builder: (context, AsyncSnapshot<bool> snapshot) {
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
                    return FutureBuilder<bool>(
                      future: FirestoreServices().isPlayerAlive(user.email!),
                      builder: (context, AsyncSnapshot<bool> aliveSnapshot) {
                        if (aliveSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.black,
                          );
                        } else if (aliveSnapshot.hasError) {
                          return const Center(
                            child: Text("Error checking player status"),
                          );
                        } else {
                          bool isAlive = aliveSnapshot.data ?? false;

                          if (isAlive) {
                            // Player is alive, navigate to HomeScreen
                            FirestoreServices()
                                .playerTeam(user.email!)
                                .then((value) {
                              return const WaitingScreen();
                            });

                            return Container();
                          } else {
                            // Player is dead, navigate to DeadScreen
                            return const DeathScreen();
                          }
                        }
                      },
                    );
                  } else {
                    return const JoinTeamScreen();
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
