import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/profile.dart';
import 'package:revent/pages/home_page.dart';
import 'package:revent/services/auth_service.dart';
import 'package:revent/widgets/generic_list.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Genre> favorites = [];
  String displayName;

  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  var txt2 = TextEditingController();

  @override
  void initState() {
    this.displayName = AuthService.currentUser().displayName;
    super.initState();
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
        firstDate: DateTime(1900, 0, 0),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        txt.text = "$picked".split(" ")[0].split("-").reversed.join(".");
      });
  }

  Future<void> _createUser() async {
    await Profile.create(selectedDate, displayName, favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
                  if (input.isEmpty) {
                    return "Youre name is empty.";
                  }

                  if (input.length < 3) {
                    return "Youre name is too short...";
                  }

                  return null;
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  icon: Icon(Icons.text_fields, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Choose your display name!",
                  labelText: "Display Name *",
                ),
                onSaved: (String value) {
                  this.displayName = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: txt,
                  readOnly: true,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(Icons.cake_sharp, color: Colors.white),
                    hintText: "Set your birthday!",
                  ),
                  onTap: () {
                    _selectBirthDate(context);
                  }),
              SizedBox(
                height: 10,
              ),
              TextField(
                  readOnly: true,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(Icons.cake_sharp, color: Colors.white),
                    hintText: "Whats your favorite labels...",
                  ),
                  controller: txt2,
                  onTap: () {
                    List<Genre> list = Genre.values.toList();
                    Function builder = (e) => e.toString().split(".").last;
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) =>
                            GenericList<Genre>(list, builder, this.favorites),
                      ),
                    )
                        .then((value) {
                      this.favorites = [];
                      value.forEach((element) => this.favorites.add(element));

                      setState(() {
                        txt2.text = this
                            .favorites
                            .map((e) => "#" + e.toString().split(".").last)
                            .join(" ");
                      });
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: TextButton(
                      child: Text(
                        "Lets celebrate!",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      autofocus: true,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(25.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(900.0),
                            side: BorderSide(color: secondary),
                          ),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          _createUser().then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              ));
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
