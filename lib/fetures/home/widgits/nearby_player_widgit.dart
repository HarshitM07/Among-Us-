import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NearbyPlayersListWidgit extends StatefulWidget {
  const NearbyPlayersListWidgit({super.key});

  @override
  State<NearbyPlayersListWidgit> createState() =>
      _NearbyPlayersListWidgitState();
}

class _NearbyPlayersListWidgitState extends State<NearbyPlayersListWidgit> {
  var allplayersLocationstream =
      FirebaseFirestore.instance.collection("Locations").snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              child: const Text(
                "SABOTAGE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )),
        ),
        StreamBuilder(
          stream: allplayersLocationstream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int noOfTeams = snapshot.data!.size;

              if (noOfTeams == 1) {
                return const Text("No players in the game other then you!! ");
              } else {
                return const Text("Kuch to h beta ");
              }
            } else {
              return const Text("No player Close yet !! ");
            }
          },
        )
      ],
    );
  }
}
