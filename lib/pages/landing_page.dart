import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/pages/auth/login/login_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primary,
        title: Center(
          child: Text(
            "revent",
            style: TextStyle(
              fontFamily: "Poppings",
              fontSize: 25.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "wanna celebrate\nyour life?",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 100.0,
            ),
            TextButton(
              child: const Text(
                "wanna start?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              autofocus: true,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.fromLTRB(175.0, 25.0, 175.0, 25.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(900.0),
                    side: BorderSide(color: secondary),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
