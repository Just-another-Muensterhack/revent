import 'dart:math';

import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/pages/auth/login/select_interests_page.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Genre> favorites = [];
  String displayName = "";
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();


  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 0, 0),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        txt.text = "$picked".split(" ")[0];
      });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We require some additional information !",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String input) {
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white54
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  //icon: Icon(Icons.title),
                  hintText: "Choose your display name!",
                  labelText: "Display Name *",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txt,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.white54
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  //icon: Icon(Icons.title),
                  hintText: "Choose your display name!",
                  labelText: "Your Birthday *",
                ),
                onTap: () {
                  _selectBirthDate(context);
                }
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (String input) {
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.white54
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  //icon: Icon(Icons.title),
                  hintText: "Choose your favorite genres!",
                  labelText: "Favorites",
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectInterestsPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
