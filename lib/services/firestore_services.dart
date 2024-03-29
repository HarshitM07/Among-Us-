import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  var users = FirebaseFirestore.instance.collection("users");

  Future<void> addUsersData(String name, String age, String gender,
      String contactNo, String address, String email) {
    return users.add({
      "Name": name,
      "Age": age,
      "Gender": gender,
      "ContactNo": contactNo,
      "Address": address,
      "Email": email,
      "timestamp": Timestamp.now(),
    });
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await users.where('Email', isEqualTo: email).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }
}
