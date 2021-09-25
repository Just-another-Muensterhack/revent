import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/main.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/pages/catch_screen.dart';
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
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 36,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Genre.values.length,
                  itemBuilder: (context, index) {
                    Genre genre = Genre.values[index];

                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      height: 8,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
                              colors: const <Color>[

                                Color.fromARGB(150, 176, 128, 248),
                                Color.fromARGB(125, 130,  81, 202),
                                Color.fromARGB(100, 165, 131, 215),
                              ],
                              tileMode: TileMode.repeated
                          )
                        ),
                        child: Center(child: Text(genre.toString().substring(6, 7).toUpperCase() + genre.toString().substring(7), style: TextStyle(fontWeight: FontWeight.w700)))
                      )
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Events",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: Colors.white12,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
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
        leading: IconButton(
            onPressed: () async => (AuthService.signInWithGoogle()),
            icon: Icon(Icons.menu)),
        title: Center(
          child: Text(
            "revent",
            style: TextStyle(fontFamily: "Poppings"),
          ),
        ),
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
        ],
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
