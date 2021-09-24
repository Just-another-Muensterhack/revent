import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/main.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/pages/map_page.dart';
import 'package:revent/pages/explore_page.dart';
import 'package:revent/pages/profile_page.dart';

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
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Genre.values.length,
                  itemBuilder: (context, index) {
                    Genre genre = Genre.values[index];

                    return Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: const Text("AB"),
                      ),
                      label: Text(genre.toString().substring(6,7).toUpperCase() + genre.toString().substring(7)),
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
      return ExplorePage();
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
        leading: IconButton(onPressed: () => null, icon: Icon(Icons.menu)),
        title: Center(
          child: Text(
            "revent",
            style: TextStyle(fontFamily: "Poppings"),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => null,
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
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Explore",
              icon: Icon(Icons.explore),
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
