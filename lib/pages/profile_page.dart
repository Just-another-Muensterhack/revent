import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:revent/pages/auth/login/login_page.dart';
import 'package:revent/services/auth_service.dart';
import 'package:revent/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 38, 49, 1.0),
      body: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, left: 50, bottom: 10),
            child: Row(children: <Widget>[]),
          ),
          Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(25)),
              child: AuthService.currentUserExists() && AuthService.currentUser().photoURL != null ? Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(AuthService.currentUser().photoURL)),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(AuthService.currentUser().displayName, style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(AuthService.currentUser().email, style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25))),
                                      child: SingleChildScrollView(child: Container(
                                        width: 500,
                                        height: 365,
                                        child: Column(children: <Widget>[
                                          Center(
                                            child: Padding(padding: EdgeInsets.only(top:25, left:25, right: 25, bottom: 15),
                                              child: QrImage(
                                              data: "XEMSq8VUjj",
                                              version: QrVersions.auto,
                                              size: 200.0,)
                                          )),
                                          Padding(padding: EdgeInsets.only(bottom: 15),
                                            child: Center(child: Text("XEMSq8VUjj", style: TextStyle(color: Colors.black),)),),
                                          Padding(padding: EdgeInsets.only(left: 25, right: 25),
                                            child: CustomButton(buttonText: "Copy", onPress: (){
                                              Clipboard.setData(ClipboardData(text: "XEMSq8VUjj"));
                                            },),
                                          )
                                          ],
                                        )
                                      )));
                                },
                                context: context);
                            },
                            icon: Icon(Icons.qr_code)),
                        )))
                ],
              ) : Container()),
          Container(height: 40),
          Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(25)),
            child: Column(children: <Widget>[
              ListTile(
                title: const Text("Account",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  onPressed: () => {})),
              ListTile(
                title: const Text("Friends",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  onPressed: () => {})),
              ListTile(
                title: const Text("Notifications",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  onPressed: () => {})),
              ListTile(
                title: const Text("Data & Privacy",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  onPressed: () => {})),
              ListTile(
                title: const Text("Impressum",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: Colors.white,
                  onPressed: () => {})),
              ListTile(
                title: const Text("Logout",
                  style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: Colors.white,
                  onPressed: () => AuthService.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()))),
                )
              )
              ]))
        ])));
  }
}
