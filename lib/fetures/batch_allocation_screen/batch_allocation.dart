import 'dart:async';

import 'package:among_us2/fetures/home/home_screen.dart';
import 'package:among_us2/main.dart';
import 'package:flutter/material.dart';

class BatchAllocationScreen extends StatefulWidget {
  const BatchAllocationScreen({super.key});

  @override
  State<BatchAllocationScreen> createState() => _BatchAllocationScreenState();
}

class _BatchAllocationScreenState extends State<BatchAllocationScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (ctx) => HomeScreen(
                    teamName: GlobalteamName,
                  )),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("here you will knew you are imposter or crewmate"),
      ),
    );
  }
}
