import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget{

  @override 
  Widget build(BuildContext context){
    return FlatButton(
      child: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context)
    );
  }

}