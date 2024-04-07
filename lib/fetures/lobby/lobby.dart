import 'package:among_us2/fetures/lobby/randomImposterOrCrewmateGen.dart';
import 'package:among_us2/fetures/waiting_area/wating_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  LobbyScreen({super.key, required this.teamId});
  String teamId;
  int players = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: const Color.fromARGB(0, 0, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            if (players >= 4) {
              //TODO
              //RandomImpostorOrCrewmateGen().impostorOrCrewmate();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => const WaitingScreen()),
                  (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("You need 4 players to join the game ")));
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(228, 223, 174, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              "assets/group.png",
              height: 210,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: null,
                child: Text("Team Name : $teamId")),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Teams')
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

                players = snapshot.data!.docs.length;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot player = snapshot.data!.docs[index];
                          return Card(
                            color: Color.fromARGB(255, 140, 130, 98),
                            child: ListTile(
                              title: Text(
                                player['name'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(player['email'],
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(142, 255, 255, 255))),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
