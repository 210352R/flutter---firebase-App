import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final brewCollection = FirebaseFirestore.instance.collection('brews');

  // add user data to firestore using add method
  Future<void> updateUserData(String sugars, String name, int strength) async {
    print(
        "addUserData ---------------------------------------------- > ----------------------------");

    await brewCollection.add({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    }).then((value) {
      print(
          "Document added with ID: ${value.id}  --------------------------------  ");
    }).catchError((error) {
      print("Error adding document: $error");
    });

    print(
        "Wade wela ----------------------------- >>>>>>>>>>>>>>>>>>>>>>>>>> ");
  }
}
