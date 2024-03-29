import 'package:among_us2/fetures/batch_allocation_screen/batch_allocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var gameStatusInstance = FirebaseFirestore.instance
        .collection("GameStatus")
        .doc("Status")
        .snapshots();
    return StreamBuilder(
      stream: gameStatusInstance,
      builder: (context, snapshot) {
        if (snapshot.data!["status"] == false) {
          return Stack(
            children: [
              Image.asset(
                "assets/waiting.png",
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              const Center(
                child: SizedBox(
                  height: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Color.fromRGBO(75, 62, 26, 1),
                  ),
                ),
              )
            ],
          );
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (ctx) => const BatchAllocationScreen()),
              (route) => false);
          return const Placeholder();
        }
      },
    );
  }
}
