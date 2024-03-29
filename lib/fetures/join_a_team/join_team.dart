import 'package:among_us2/fetures/lobby/lobby.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
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
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamCodeController = TextEditingController();

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
                    controller: _teamNameController,
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
                    controller: _teamCodeController,
                    decoration: InputDecoration(
                      hintText: 'Team Code',
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
                    onPressed: () {
                      if (_teamNameController.text.isEmpty ||
                          _teamCodeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter both Team Name and Team Code.',
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LobbyScreen(),
                          ),
                        );
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
                      'Ready to play',
                      style: TextStyle(color: Colors.white),
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
