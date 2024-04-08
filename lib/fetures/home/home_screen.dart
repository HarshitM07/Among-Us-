import 'dart:async';

import 'package:among_us2/core/geolocator_services.dart';
import 'package:among_us2/fetures/death_screen/dead_screen.dart';
import 'package:among_us2/fetures/home/widgits/map_widgit.dart';
import 'package:among_us2/fetures/home/widgits/nearby_player_widgit.dart';
import 'package:among_us2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.teamName});

  String teamName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var allplayersLocationInstance =
      FirebaseFirestore.instance.collection("Locations");
  late GeolocatorServices geoservices;

  @override
  void initState() {
    geoservices = GeolocatorServices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          actions: const [
            Text(
              "you are a",
              style: TextStyle(fontSize: 10),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Imposter",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
          title: const Text('Home'),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("AllPlayers")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   // While data is loading
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            if (snapshot.hasError) {
              //If any error occurred
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              // If there is no data available
              return const Center(
                child: Text('No Data Available'),
              );
            } else {
              // Data has been successfully loaded
              final data = snapshot.data!.data() as Map<String, dynamic>;
              // Access your document fields using 'data' map
              if (data["IsAlive"] == true && data["Character"] == "imposter") {
                Timer.periodic(const Duration(seconds: 5), (timer) async {
                  location = await geoservices.determinePosition();
                  allplayersLocationInstance.doc(GlobalteamName).set({
                    "Lat": location!.latitude,
                    "Long": location!.longitude,
                    "Team": GlobalteamName
                  });

                  setState(() {});
                });
                return SlidingSheet(
                  elevation: 8,
                  cornerRadius: 16,
                  snapSpec: const SnapSpec(
                    // Enable snapping. This is true by default.
                    snap: true,
                    // Set custom snapping points.
                    snappings: [0.1, 0.7, 1.0],
                    // Define to what the snappings relate to. In this case,
                    // the total available space that the sheet can expand to.
                    positioning: SnapPositioning.relativeToAvailableSpace,
                  ),
                  // The body widget will be displayed under the SlidingSheet
                  // and a parallax effect can be applied to it.
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MapWidgit(),
                  ),
                  builder: (context, state) {
                    // This is the content of the sheet that will get
                    // scrolled, if the content is bigger than the available
                    // height of the sheet.
                    return const SizedBox(
                      height: 500,
                      child: Center(
                        // content on the sheet
                        child: NearbyPlayersListWidget(),
                      ),
                    );
                  },
                );
              } else if (data["IsAlive"] == true &&
                  data["Character"] == "crewmate") {
                return SlidingSheet(
                  elevation: 8,
                  cornerRadius: 16,
                  snapSpec: const SnapSpec(
                    // Enable snapping. This is true by default.
                    snap: true,
                    // Set custom snapping points.
                    snappings: [0.1, 0.7, 1.0],
                    // Define to what the snappings relate to. In this case,
                    // the total available space that the sheet can expand to.
                    positioning: SnapPositioning.relativeToAvailableSpace,
                  ),
                  // The body widget will be displayed under the SlidingSheet
                  // and a parallax effect can be applied to it.
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MapWidgit(),
                  ),
                  builder: (context, state) {
                    // This is the content of the sheet that will get
                    // scrolled, if the content is bigger than the available
                    // height of the sheet.
                    return const SizedBox(
                      height: 500,
                      child: Center(
                        // content on the sheet
                        child: Center(
                          child: Text("These are your tasks .........."),
                        ),
                      ),
                    );
                  },
                );
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => const DeathScreen()),
                    (route) => false);
                return const Center(
                  child: Text("You are dead !!"),
                );
              }
            }
          },
        ));
  }
}








// SlidingSheet(
//         elevation: 8,
//         cornerRadius: 16,
//         snapSpec: const SnapSpec(
//           // Enable snapping. This is true by default.
//           snap: true,
//           // Set custom snapping points.
//           snappings: [0.1, 0.7, 1.0],
//           // Define to what the snappings relate to. In this case,
//           // the total available space that the sheet can expand to.
//           positioning: SnapPositioning.relativeToAvailableSpace,
//         ),
//         // The body widget will be displayed under the SlidingSheet
//         // and a parallax effect can be applied to it.
//         body: const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: MapWidgit(),
//         ),
//         builder: (context, state) {
//           // This is the content of the sheet that will get
//           // scrolled, if the content is bigger than the available
//           // height of the sheet.
//           return const SizedBox(
//             height: 500,
//             child: Center(
//               // content on the sheet
//               child: NearbyPlayersListWidget(),
//             ),
//           );
//         },
//       ),
 