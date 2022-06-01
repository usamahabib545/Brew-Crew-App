import 'package:brew/services/auth.dart';
import 'package:brew/shared/loading.dart';
import 'package:brew/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        title: Text('Sign In to Brew!!'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              "Register",
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
            SButton(
              text: ("Sign In Annon"),
              onpress: () async {
                setState(() {
                  loading = true;
                });
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print("Error Signing In");
                } else {
                  print("Signed In");
                  print(result.uid);
                }
              },
            ),
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
                    text: "Sign In",
                    onpress: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result =
                            await _auth.signInrWithEmailAndPassword(
                                email.trim(), password.trim());
                        if (result == null) {
                          setState(() {
                            error =
                                "Could Not Sign In, Please enter a valid Email and Password";
                            loading = false;
                          });
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  ),
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
                ])),
          ],
        ),
      ),
    );
  }
}
