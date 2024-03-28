import 'package:flutter/material.dart';

class NearbyPlayersListWidgit extends StatefulWidget {
  const NearbyPlayersListWidgit({super.key});

  @override
  State<NearbyPlayersListWidgit> createState() =>
      _NearbyPlayersListWidgitState();
}

class _NearbyPlayersListWidgitState extends State<NearbyPlayersListWidgit> {
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
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: const Text("Player Name"),
                trailing:
                    ElevatedButton(onPressed: () {}, child: const Text("KILL")),
              );
            },
          ),
        ),
      ],
    );
  }
}
