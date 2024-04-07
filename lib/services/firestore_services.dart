import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  var teams = FirebaseFirestore.instance.collection('Teams');
  var allplayers = FirebaseFirestore.instance.collection("AllPlayers");

  Future<String> removePlayerFromTeam(
      String teamName, String playerEmail) async {
    try {
      // Get the reference to the team document in Firestore

      // Check if the team exists
      var teamSnapshot = teams.doc(teamName).collection("players");

      teamSnapshot.doc(playerEmail).delete();

      return "success";
    } catch (e) {
      print("Error removing player from team: $e");
      return "An error occurred"; // Return error message
    }
  }

  // Future<void> addUsersData(String name, String age, String gender,
  //     String contactNo, String address, String email) {
  //   return users.add({
  //     "Name": name,
  //     "Age": age,
  //     "Gender": gender,
  //     "ContactNo": contactNo,
  //     "Address": address,
  //     "Email": email,
  //     "timestamp": Timestamp.now(),
  //   });
  // }

  Future<String> addPlayerToGame(
      String name, String email, String teamName, String character) async {
    try {
      allplayers.add({
        "Name": name,
        "Email": email,
        "Character": character,
        "TeamName": teamName,
        "isAlive": true
      });

      return "success";
    } catch (e) {
      return "Can't join : $e";
    }
  }

  Future<String> addPlayerToTeam(
      String teamId, String name, String email) async {
    try {
      var players = await teams.doc(teamId).collection('players').get();
      int noOfPlayers = players.size;

      if (noOfPlayers < 4) {
        // Get reference to Firestore collection "teams"

        // Get reference to the specific team document
        DocumentReference teamDocRef = teams.doc(teamId);

        // Add the player to the "players" subcollection of the team

        await teamDocRef.collection('players').doc(email).set({
          'name': name,
          'email': email,
        });

        return "success";
      } else {
        var teamPlayerRef =
            await teams.doc(teamId).collection('players').doc(email).get();
        print("email $email");
        if (teamPlayerRef.exists) {
          print("andar aa agaya .........");
          DocumentReference teamDocRef = teams.doc(teamId);

          // Add the player to the "players" subcollection of the team

          await teamDocRef.collection('players').doc(email).set({
            'name': name,
            'email': email,
          });

          return "success";
        } else {
          return "This lobby alredy have 4 Players  ";
        }
      }
    } catch (e) {
      print('Error adding player to team: $e');
      // Handle error accordingly
      return "Error try again : $e";
    }
  }

  Future<Widget> GetListNearby(String TeamName) async {
    var playersInstance = await teams.doc(TeamName).collection("players").get();

    List<Widget> teamPlayerList = [];

    for (var i = 0; i < playersInstance.size; i++) {
      teamPlayerList.add(ListTile(
        title: playersInstance.docs[0]["name"],
        subtitle: playersInstance.docs[0]["email"],
        trailing: ElevatedButton(onPressed: () {}, child: const Text("Kill")),
      ));
    }

    return Expanded(
        child: Column(
      children: teamPlayerList,
    ));
  }

  // Future<Map<String, dynamic>?> teamNameMatch(String teamName) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await allplayers.where('TeamName', isEqualTo: teamName).get();
  //    var wd =  querySnapshot.docs;
  //   if (querySnapshot.docs.isNotEmpty) {
  //     return querySnapshot.docs.data();
  //   } else {
  //     return null;
  //   }
  // }

  Future<bool> isPlayerRegistered(String userEmail) async {
    try {
      // Query the Firestore collection 'AllPlayers' based on the user's email
      var playerQuery = await FirebaseFirestore.instance
          .collection('AllPlayers')
          .where('Email', isEqualTo: userEmail)
          .get();

      if (playerQuery.docs[0]['Email'] == userEmail) {
        print("Player alredy exists");

        return true;
      } else {
        print("player do no exist");
        return false;
      }
    } catch (e) {
      print('Error checking player registration: $e');
      return false;
    }
  }

  Future<String> playerTeam(String userEmail) async {
    try {
      // Query the Firestore collection 'AllPlayers' based on the user's email
      var playerQuery = await FirebaseFirestore.instance
          .collection('AllPlayers')
          .doc(userEmail)
          .get();

      // Check if any document exists with the given user's email
      return playerQuery["TeamName"];
    } catch (e) {
      print('Error checking player registration: $e');
      return "NO";
    }
  }
}
