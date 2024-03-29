import 'package:among_us2/fetures/home/home_screen.dart';
import 'package:among_us2/fetures/landing/screen/landing_page.dart';
import 'package:among_us2/fetures/verify_email/verify_email_screen.dart';
import 'package:among_us2/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
var socket;
void main() async {
  Map<String, dynamic>? userData;

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return const Material(
  //     color: Colors.black,
  //     child: SizedBox(
  //       child: Center(
  //         child: Text(
  //           "OOPs!!, Some problem occurred...",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
  //         ),
  //       ),
  //     ),
  //   );
  // };
  runApp(MaterialApp(
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.black,
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong !!!"),
              );
            } else if (snapshot.hasData) {
              bool isemailVerified =
                  FirebaseAuth.instance.currentUser!.emailVerified;

              print(isemailVerified);
              print(FirebaseAuth.instance.currentUser!.email);

              if (isemailVerified) {
                //TODO

                return const HomeScreen();
              } else {
                return const VerifyEmail();
              }
            }
            return LandingPage();
          })));
}
