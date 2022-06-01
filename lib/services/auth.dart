import 'package:brew/models/user.dart';
import 'package:brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User obj based on Firebase

  UserModel? _userFromFirebaseUSer(User? user){

    return user!= null ? UserModel(uid: user.uid):null;
  }

  //auth change user Stream

  Stream<UserModel?> get user{
    return _auth.authStateChanges()
    //.map((User? user) => _userFromFirebaseUSer(user!));
    .map(_userFromFirebaseUSer);
  }

  //Sign in anon

  Future signInAnon()async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
     return _userFromFirebaseUSer(user!);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //Sign in with email and password

  Future signInrWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUSer(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //Register with email and password

  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid

      await DatabaseService(uid: user!.uid).updateUserData("0", "New Crew Member", 100);

      return _userFromFirebaseUSer(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //Sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}