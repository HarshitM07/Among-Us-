import 'package:flutter/material.dart';

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
        // appBar: AppBar(
        //   title: Text('Name Your Crew'),
        // ),
        body: Stack(fit: StackFit.expand, children: [
      Image.asset(
        'assets/NameYourTeam (1).png',
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.all(45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Positioned(
            //   top: 100,
            //   left: 0,
            //   child: Container(
            //     width: 257, // Set the desired width
            //     height: 33, // Set the desired height
            //     child: Image.asset(
            //       'assets/NAME YOUR CREW.png',
            //       fit: BoxFit.cover, // Adjust image fit as needed
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // Positioned(
            //   top: 20,
            //   left: 0,
            //   child: Container(
            //     width: 162, // Set the desired width
            //     height: 149, // Set the desired height
            //     child: Image.asset(
            //       'assets/Group 5.png',
            //       fit: BoxFit.cover, // Adjust image fit as needed
            //     ),
            //   ),
            // ),
            SizedBox(height: 300),
            Positioned(
              top: 0,
              left: 0,
              child: TextField(
                controller: _teamNameController,
                decoration: InputDecoration(
                  hintText: 'Team Name',
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement your ready to play logic here
              },
              child: Text('Ready to play'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(75, 62, 26, 1),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    ]));
  }
}
