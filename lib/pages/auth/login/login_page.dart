import 'package:flutter/material.dart';
import 'package:revent/pages/auth/login/data_page.dart';
import 'package:revent/services/auth_service.dart';
import 'package:revent/widget/custom_button.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {

    void _sendForm(){
      //sign in and open data page
      AuthService.signInWithGoogle().then(
              (value) => Navigator.push(context, MaterialPageRoute(
              builder: (context) => DataPage()
          ))
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomButton(buttonText: "Sign in with Google", onPress: () => _sendForm(),)
          ],
        ),
      )
    );
  }

}