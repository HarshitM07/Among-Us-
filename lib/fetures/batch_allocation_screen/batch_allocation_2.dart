import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  // Firebase.initializeApp();
  runApp(const MaterialApp(
    home: BatchAllocationScreen(),
  ));
}

class BatchAllocationScreen extends StatelessWidget {
  const BatchAllocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 249, 219, 1),
      body: Center(
        child: Stack(
          children: [
            // Background image
            // Image.asset(
            //   'assets/Component 7.png',
            //   fit: BoxFit.none,
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            Positioned(
              // Adjust the values below to position "Component 6.png" as desired
              left: -25, // Change this value to position horizontally
              top: 120, // Change this value to position vertically
              child: Image.asset(
                "assets/Component 7.png",
                height: 640, // Adjust the height as needed
                fit: BoxFit.fitWidth,
              ),
            ),
            // Text widget

            Center(
              child: Text(
                "You are a Crewmate",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(110, 97, 62, 1),
                    fontFamily: WebSocket.userAgent),
                textAlign: TextAlign.center,
              ),
            ),
            // Insert more images or widgets as needed
          ],
        ),
      ),
    );
  }
}
