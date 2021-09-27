import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/catch.dart';
import 'package:revent/models/event.dart';

class CreateCatchPage extends StatefulWidget {
  final List<Event> events;

  CreateCatchPage(this.events);

  @override
  State<StatefulWidget> createState() {
    return _CreateCatchPageState();
  }
}

class _CreateCatchPageState extends State<CreateCatchPage> {
  String _title;
  String _description;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _dateTime = value;
      });
    });
  }

  void _openTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    ).then((value) {
      setState(() {
        _timeOfDay = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          title: Text("Catching..."),
        ),
        backgroundColor: primary,
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            TextField(
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
                hintText: "Title",
              ),
              onChanged: (value) => this.setState(() {
                this._title = value;
              }),
            ),
            Container(
              height: 20,
            ),
            TextField(
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
                hintText: "Description",
              ),
              onChanged: (value) => this.setState(() {
                this._description = value;
              }),
            ),
            Container(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white12,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () async => _openDatePicker(context),
                      leading: Icon(
                        Icons.event_note,
                        color: Colors.white,
                      ),
                      title: Text(_dateTime.day.toString().padLeft(2, "0") +
                          ":" +
                          _dateTime.month.toString().padLeft(2, "0") +
                          ":" +
                          _dateTime.year.toString().padLeft(4, " ")),
                    ),
                    ListTile(
                      onTap: () async => _openTimePicker(context),
                      leading: Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      title: Text(_timeOfDay.hour.toString().padLeft(2, "0") +
                          ":" +
                          _timeOfDay.minute.toString().padLeft(2, "0")),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white12,
                child: ListTile(
                    title: Text("add Friends"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreateCatchInviteFriendsPage(),
                          ));*/
                    }),
              ),
            ),
            Expanded(child: Container()),
            TextButton(
              child: Text(
                "Create Catch",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Catch cat = await Catch.create(
                    widget.events.map((e) => e.databaseID).toList());
                cat.time = DateTime(_dateTime.year, _dateTime.month,
                    _dateTime.day, _timeOfDay.hour, _timeOfDay.minute);
                cat.title = _title;
                cat.description = _description;
                await cat.save();
              },
            ),
          ],
        ),
      ),
    );
  }
}
