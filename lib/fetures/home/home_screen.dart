import 'dart:async';
import 'dart:isolate';

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
  late ReceivePort _receivePort;
  late Isolate _mapIsolate;
  late Isolate _playersListIsolate;

  @override
  void initState() {
    geoservices = GeolocatorServices();
    _initIsolates();
    super.initState();
  }

  @override
  void dispose() {
    _mapIsolate.kill(priority: Isolate.immediate);
    _playersListIsolate.kill(priority: Isolate.immediate);
    _receivePort.close();
    super.dispose();
  }

  void _initIsolates() {
    _receivePort = ReceivePort();
    Timer(
      Duration.zero,
      () async {
        _mapIsolate =
            await Isolate.spawn(_runMapIsolate, _receivePort.sendPort);
        _playersListIsolate =
            await Isolate.spawn(_runPlayersListIsolate, _receivePort.sendPort);
      },
    );
  }

  static void _runMapIsolate(SendPort sendPort) {
    // Code to run the map on a separate isolate
    // ...
  }

  static void _runPlayersListIsolate(SendPort sendPort) {
    // Code to run the nearby players list on a separate isolate
    // ...
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
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Center(
                child: Text('No Data Available'),
              );
            } else {
              final data = snapshot.data!.data() as Map<String, dynamic>;
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
                    snap: true,
                    snappings: [0.1, 0.7, 1.0],
                    positioning: SnapPositioning.relativeToAvailableSpace,
                  ),
                  body: const MapWidget(),
                  builder: (context, state) {
                    return const SizedBox(
                      height: 500,
                      child: Center(
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
                    snap: true,
                    snappings: [0.1, 0.7, 1.0],
                    positioning: SnapPositioning.relativeToAvailableSpace,
                  ),
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MapWidget(),
                  ),
                  builder: (context, state) {
                    return const SizedBox(
                      height: 500,
                      child: Center(
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
