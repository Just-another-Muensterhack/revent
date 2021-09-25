import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/profile.dart';
import 'package:revent/pages/auth/login/data_page.dart';
import 'package:revent/pages/home_page.dart';
import 'package:revent/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _next(BuildContext context) async {
    bool exists =
        await Profile.profileExists(userUID: AuthService.currentUser().uid);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => exists ? HomePage() : DataPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign in with",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Container(
                height: 5.0,
              ),
              SignInButton(
                Buttons.Google,
                text: "Google",
                onPressed: () =>
                    AuthService.signInWithGoogle().then((value) async {
                  this._next(context);
                }),
              ),
              /*
              Container(
                height: 10.0,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 10.0,
              ),
              SignInButton(
                Buttons.Email,
                text: "E-Mail",
                onPressed: () => AuthService.signInAnonymously()
                    .then((value) => this._goToHomePage(context)),
              ),*/
            ],
          ),
        ));
  }
}
