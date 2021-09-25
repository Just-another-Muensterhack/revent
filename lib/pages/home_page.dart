import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/main.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/pages/catch_screen.dart';
import 'package:revent/pages/explore_page.dart';
import 'package:revent/pages/map_page.dart';
import 'package:revent/pages/profile_page.dart';
import 'package:revent/widgets/generic_list.dart';
import 'package:revent/services/auth_service.dart';
import 'package:revent/widgets/floating_navbar.dart';

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
            onPressed: () {
              List<int> list = [1, 2, 3, 5, 0];
              Function builder = (element) => element.toString();

              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (context) => GenericList<int>(list, builder),
                    ),
                  )
                  .then(
                    (value) => print(value),
                  );
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
        child: FloatingNavbar(
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
            FloatingNavbarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            FloatingNavbarItem(
              label: "Explore",
              icon: Icon(Icons.explore),
            ),
            FloatingNavbarItem(
              label: "Map",
              icon: Icon(Icons.map),
            ),
            FloatingNavbarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
