import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/main.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/pages/catch_screen.dart';
import 'package:revent/pages/explore_page.dart';
import 'package:revent/pages/map_page.dart';
import 'package:revent/pages/profile_page.dart';
import 'package:revent/services/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

Widget _getWidgetOptions(int index, BuildContext context) {
  switch (index) {
    case 0:
      return ExplorePage();
    case 1:
      return CatchPage();
    case 2:
      return MapPage();
    case 3:
      return ProfilePage();
  }

  return Container(
    child: Text(
      "Error Navigation Index out of Bounds",
    ),
  );
}

class _HomePageState extends State<HomePage> {
  int _navigationbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0.0,
        /*
        leading: IconButton(
            onPressed: () async => (AuthService.signInWithGoogle()),
            icon: Icon(Icons.menu)),*/
        title: Center(
          child: Text(
            "revent",
            style: TextStyle(fontFamily: "Poppings"),
          ),
        ),
        /*
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              //TODO test here
            },
          )
        ],*/
      ),
      body: _getWidgetOptions(_navigationbarIndex, context),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: primary,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: secondary,
          unselectedItemColor: Colors.grey,
          backgroundColor: primary,
          currentIndex: _navigationbarIndex,
          onTap: (value) {
            setState(() {
              _navigationbarIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Explore",
              icon: Icon(Icons.explore),
            ),
            BottomNavigationBarItem(
              label: "Catch",
              icon: Icon(Icons.cake),
            ),
            BottomNavigationBarItem(
              label: "Map",
              icon: Icon(Icons.map),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
