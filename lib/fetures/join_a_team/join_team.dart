import 'package:among_us2/fetures/lobby/lobby.dart';
import 'package:among_us2/main.dart';
import 'package:among_us2/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  Firebase.initializeApp();
  runApp(const MaterialApp(
    home: JoinTeamScreen(),
  ));
}

class JoinTeamScreen extends StatefulWidget {
  const JoinTeamScreen({super.key});

  @override
  _JoinTeamScreenState createState() => _JoinTeamScreenState();
}

class _JoinTeamScreenState extends State<JoinTeamScreen> {
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9DB),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/group.png",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextField(
                    controller: _playerNameController,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(107, 10, 15, 19),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(228, 223, 174, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _teamNameController,
                    decoration: InputDecoration(
                      hintText: 'Team Name (e.g. TattiTeam )',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(110, 10, 15, 19),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(228, 223, 174, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_playerNameController.text.isEmpty ||
                          _teamNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter both Your Name and Team Name.',
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          loading = true;
                        });
                        String res = await FirestoreServices().addPlayerToTeam(
                            _teamNameController.text.trim(),
                            _playerNameController.text.trim(),
                            FirebaseAuth.instance.currentUser!.email!);

                        if (res == "success") {
                          GlobalteamName = _teamNameController.text;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LobbyScreen(
                                teamName: _teamNameController.text,
                              ),
                            ),
                            (route) => true,
                          );
                          setState(() {
                            loading = false;
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(res)));

                          setState(() {
                            loading = false;
                          });
                        }
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
                    child: loading == false
                        ? const Text(
                            'Ready to play',
                            style: TextStyle(color: Colors.white),
                          )
                        : const CircularProgressIndicator(
                            color: Color.fromRGBO(228, 223, 174, 1),
                          ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
