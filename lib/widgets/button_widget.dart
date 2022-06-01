import 'package:flutter/material.dart';

class SButton extends StatelessWidget {
  SButton({Key? key, required this.onpress,required this.text}) : super(key: key);
  String text;
  Function onpress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown.shade300),
        ),
        child: Text(text, style: TextStyle(
          color: Colors.white,
        ),),
        onPressed: () async{
          onpress();
        },
      ),
    );
  }
}
