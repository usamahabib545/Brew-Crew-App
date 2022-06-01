import 'package:brew/models/brew.dart';
import 'package:brew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection Reference

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugar": sugars,
      "name": name,
      "strength": strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc['name'] ?? '',
        strength: doc['strength'] ?? 0,
        sugars: doc['sugar'] ?? '0',
      );
    }).toList();
  }

  //userData From Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugar'],
      strength: snapshot['strength'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    print("Here it is");
    print(brewCollection.snapshots);
    return brewCollection.snapshots().map(_brewListFromSnapshot);

  }

  //get user doc Stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}
