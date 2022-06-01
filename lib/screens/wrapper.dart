import 'package:brew/models/user.dart';
import 'package:brew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    //return either Home or Authenticate Widget
   if(user == null){
      return Authenticate();
    }
   else{
     return Home();
   }
  }
}
