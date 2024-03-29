import 'package:flutter/material.dart';
import 'package:among_us2/badgeAllocation.dart';

class NameYourTeam extends StatefulWidget {
  @override
  _NameYourTeamState createState() => _NameYourTeamState();
}

class _NameYourTeamState extends State<NameYourTeam> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter, // Aligning children to the bottom
        children: [
          Image.asset(
            'assets/NameYourTeam (1).png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 300),
                Positioned(
                  top: 0,
                  left: 0,
                  child: TextField(
                    controller: _teamNameController,
                    decoration: InputDecoration(
                      hintText: 'Team Name',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 10, 15, 19)),
                      filled: true,
                      fillColor: Color.fromRGBO(228, 223, 174, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 0),
                TextField(
                  controller: _teamCodeController,
                  decoration: InputDecoration(
                    hintText: 'Team Code',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 10, 15, 19)),
                    filled: true,
                    fillColor: Color.fromRGBO(228, 223, 174, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 0),
                ElevatedButton(
                  onPressed: () {
                    // Perform validation before navigating
                    if (_teamNameController.text.isEmpty ||
                        _teamCodeController.text.isEmpty) {
                      // Show a snackbar or any other feedback to inform the user about the missing fields
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please enter both Team Name and Team Code.'),
                        ),
                      );
                    } else {
                      // If both fields are not empty, navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadgeAllocation()),
                      );
                    }
                  },
                  child: Text('Ready to play'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(75, 62, 26, 1),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
