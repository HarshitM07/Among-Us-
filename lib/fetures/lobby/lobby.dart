import 'package:among_us2/fetures/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  LobbyScreen({super.key, required this.teamId});
  String teamId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 223, 174, 1),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .collection('players')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No players found for this team.'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/group.png",
                  height: 200,
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot player = snapshot.data!.docs[index];
                      return Card(
                        color: const Color.fromRGBO(75, 62, 26, 1),
                        child: ListTile(
                          title: Text(
                            player['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(player['email'],
                              style: const TextStyle(
                                  color: Color.fromARGB(87, 255, 255, 255))),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (snapshot.data!.docs.length >= 4) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const HomeScreen()),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("You need 4 players to Join the game ")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(75, 62, 26, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Join Game",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
