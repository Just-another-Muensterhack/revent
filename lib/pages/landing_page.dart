import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/widget/custom_button.dart';
import 'package:revent/widget/image_appbar.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: imageAppBar(),
      backgroundColor: Color(0xFF1F2631),
      body: Center(child: Column(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            height: 40,
          ),
          // Center(child: Image(image: AssetImage('assets/images/logo_full.png'), width: 800/8, height: 340/8)),
          Container(
            color: Colors.transparent,
            height: 230,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                const Text("wanna celebrate your life?", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600)),
                Container(
                  color: Colors.transparent,
                  height: 40,
                ),
                Container(
                  child: CustomButton(buttonText: "Get Started", color: Colors.white, onPress: () {}),
                  height: 40,
                )

              ]
            )
          ),
          Container(
            color: Colors.transparent,
            height: 260,
          ),
        ]
      ))
    );
  }
}
