import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';

class CustomButton extends StatelessWidget{
  final String buttonText;
  final Function onPress;
  final Color color;

  const CustomButton({Key? key, required this.buttonText, required this.onPress, required this.color }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(width:size.width * 0.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
        border: Border.all(color: primary, width: 2)),
        child: ClipRRect(child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.transparent), onPressed: onPress(),
          child: Text(buttonText, style: TextStyle(color: this.color),),),),
    );
  }
}