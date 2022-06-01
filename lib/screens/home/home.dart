import 'package:brew/screens/home/settings_form.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [Brew(sugars: '', name: '', strength: 0)],
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown.shade400,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text("Logout", style: TextStyle(color: Colors.black),),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(
                  Icons.settings,color: Colors.black,
              ),
              label: Text("Settings",style: TextStyle(color: Colors.black),),
              onPressed: () {
                _showSettingsPanel();
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/coffee_bg.png"),
                fit: BoxFit.cover,
              )
            ),
            child: BrewList()),
      ),
    );
  }
}
