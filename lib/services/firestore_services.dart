import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  var teams = FirebaseFirestore.instance.collection('Teams');
  var allplayers = FirebaseFirestore.instance.collection("AllPlayers");

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
        "TeamName": teamName
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
        return "This lobby alredy have 4 Players ";
      }
    } catch (e) {
      print('Error adding player to team: $e');
      // Handle error accordingly
      return "Error try again : $e";
    }
  }

  // Future<Map<String, dynamic>?> getUserByEmail(String email) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await users.where('Email', isEqualTo: email).limit(1).get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     return querySnapshot.docs.first.data();
  //   } else {
  //     return null;
  //   }
  // }
}
