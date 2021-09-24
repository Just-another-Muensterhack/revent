import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
  String hintText = '';
  final ValueChanged<String> onChanged;
  final bool obscureText;

  CustomInput({Key? key,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border.all(),),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(onChanged: (value) => onChanged(value),
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none
        ),
      ),
    );
  }
}