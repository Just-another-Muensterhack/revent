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
              TextFormField(
                validator: (String input) {
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.title),
                  hintText: "Choose your favorite genres!",
                  labelText: "Favorites *",
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
