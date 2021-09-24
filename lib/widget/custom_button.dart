import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';

class CustomButton extends StatelessWidget{
  final String buttonText;
  final Function onPress;

  const CustomButton({Key? key, required this.buttonText, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(width:size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary)),
        child: ClipRRect(child: TextButton(onPressed: () => onPress(),
          child: Text(buttonText, style: TextStyle(color: Colors.black),),),),
    );
  }
}