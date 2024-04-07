import 'package:among_us2/fetures/batch_allocation_screen/batch_allocation.dart';
import 'package:among_us2/fetures/home/home_screen.dart';
import 'package:among_us2/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Scaffold(
      body: WaitingScreen(),
    ),
  ));
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var gameStatusInstance = FirebaseFirestore.instance
        .collection("GameStatus")
        .doc("Status")
        .snapshots();
    return StreamBuilder(
      stream: gameStatusInstance,
      builder: (context, snapshot) {
        if (snapshot.data!["status"] == true ||
            snapshot.data!["status"] == true) {
          return Stack(
            children: [
              Image.asset(
                "assets/Waiting screen1.png",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                // Adjust the values below to position "Component 6.png" as desired
                left: -19, // Change this value to position horizontally
                top: 120, // Change this value to position vertically
                child: Image.asset(
                  "assets/Component 6.png",
                  height: 640, // Adjust the height as needed
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Center(
                child: SizedBox(
                  height: 33,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Color.fromRGBO(75, 62, 26, 1),
                  ),
                ),
              )
            ],
          );
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
              (route) => false);
          return const Placeholder();
        }
      },
    );
  }
}
