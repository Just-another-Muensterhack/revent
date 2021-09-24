import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/main.dart';
import 'package:revent/models/commons.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
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
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: Genre.values.length,
        itemBuilder: (context, index) {
          Genre genre = Genre.values[index];

          return Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: const Text("AB"),
            ),
            label: Text(genre.toString()),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
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
          currentIndex: 0,
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
