import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';

class CustomButton extends StatelessWidget{
  CustomButton({Key key, this.buttonText, this.onPress, this.color = Colors.white}) : super(key: key);

  final String buttonText;
  final Function onPress;
  final Color color;

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