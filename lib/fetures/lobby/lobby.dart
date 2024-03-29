import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9DB),
      body: Center(
          child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              title: Text("Player Name"),
            ),
          );
        },
      )),
    );
  }
}
