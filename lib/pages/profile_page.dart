import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:revent/models/profile.dart';
import 'package:revent/pages/auth/login/login_page.dart';
import 'package:revent/services/auth_service.dart';
import 'package:revent/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget builder(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(25))),
        child: SingleChildScrollView(
            child: Container(
                width: 500,
                height: 383,
                child: FutureBuilder(
                    future: Profile.getByReference(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: " +
                            snapshot.error
                                .toString());
                      } else {
                        return Column(
                          children: <Widget>[
                            Center(
                                child: Padding(
                                    padding:
                                    EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        right: 25,
                                        bottom: 15),
                                    child: QrImage(
                                      data: (snapshot.data as Profile).qrToken,
                                      version:
                                      QrVersions.auto,
                                      size: 200.0,
                                    ))),
                            Padding(
                              padding: EdgeInsets
                                  .only(
                                  bottom: 15),
                              child: Center(
                                  child: Text(
                                    (snapshot.data as Profile).qrToken,
                                    style: TextStyle(
                                        color: Colors
                                            .green),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 25,
                                  right: 25),
                              child: CustomButton(
                                buttonText: "Copy",
                                onPress: () {
                                  Clipboard.setData(
                                      ClipboardData(
                                          text:
                                          (snapshot.data as Profile).qrToken));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(height: 20),
                            Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 25,
                                  right: 25),
                              child: CustomButton(
                                buttonText: "Regenerate",
                                onPress: () async {
                                  (snapshot.data as Profile).generateToken();
                                  await (snapshot.data as Profile).save();
                                  setState(() {});
                                  Navigator.pop(context);
                                  showDialog(
                                      builder: this.builder,
                                      context: context);
                                },
                              ),
                            ),
                            Container(height: 20)
                          ],
                        );
                      }
                    }))));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double _avatarSize = size.height * 0.12;

    return Scaffold(
        backgroundColor: Color.fromRGBO(31, 38, 49, 1.0),
        body: Container(
            child: Column(children: <Widget>[
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(25)),
                child: AuthService.currentUserExists() &&
                    AuthService
                        .currentUser()
                        .photoURL != null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        height: _avatarSize,
                        width: _avatarSize,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                                radius: _avatarSize / 2,
                                backgroundImage: NetworkImage(
                                    AuthService
                                        .currentUser()
                                        .photoURL)))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AuthService
                            .currentUser()
                            .displayName,
                            style:
                            TextStyle(fontSize: 15, color: Colors.white)),
                        Text(AuthService
                            .currentUser()
                            .email,
                            style:
                            TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                      iconSize: _avatarSize / 3,
                      icon: Icon(Icons.qr_code, color: Colors.blue),
                      onPressed: () =>
                      {
                        showDialog(
                            builder: this.builder,
                            context: context)
                      },
                    ),
                  ],
                )

                /*ListTile(
                    trailing: IconButton(
                      icon: Icon(Icons.qr_code),
                      onPressed: () => {
                        showDialog(
                            builder: (BuildContext context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: SingleChildScrollView(
                                      child: Container(
                                          width: 500,
                                          height: 365,
                                          child: Column(
                                            children: <Widget>[
                                              Center(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 25,
                                                          left: 25,
                                                          right: 25,
                                                          bottom: 15),
                                                      child: QrImage(
                                                        data: "XEMSq8VUjj",
                                                        version:
                                                            QrVersions.auto,
                                                        size: 200.0,
                                                      ))),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                child: Center(
                                                    child: Text(
                                                  "XEMSq8VUjj",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25, right: 25),
                                                child: CustomButton(
                                                  buttonText: "Copy",
                                                  onPress: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                "XEMSq8VUjj"));
                                                  },
                                                ),
                                              )
                                            ],
                                          ))));
                            },
                            context: context)
                      },
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AuthService.currentUser().displayName,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        Text(AuthService.currentUser().email,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                    leading: Container(
                        height: this._avatarSize,
                        width: this._avatarSize,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                                radius: this._avatarSize / 2,
                                backgroundImage: NetworkImage(
                                    AuthService.currentUser().photoURL)))))*/
                    : Container(height: 40),
              ),
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
                          onPressed: () =>
                              AuthService.signOut().then((value) =>
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()))),
                        ))
                  ]))
            ])));
  }
}
