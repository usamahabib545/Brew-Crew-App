import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../widgets/button_widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text Field State
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        elevation: 0.0,
        title: Text('Sign Up In to Brew!!'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              "Sign In",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) => val!.isEmpty ? "Enter An Email" : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "Password"),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? "Enter A Password 6+ Characters Long"
                        : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SButton(
                    text: "Register",
                    onpress: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email.trim(), password.trim());
                        if (result == null) {
                          setState(() {
                            error = "Please enter a valid Email and Password";
                            loading = false;
                          });
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  ),
                ])),
            SizedBox(
              height: 12.0,
            ),
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
