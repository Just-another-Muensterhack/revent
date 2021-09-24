import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/models/event.dart';
import 'package:revent/widgets/event_item.dart';

class CatchPage extends StatefulWidget {
  _CatchPageState createState() => _CatchPageState();
}

class _CatchPageState extends State<CatchPage> {
  bool _is_ready = false;
  bool _is_error = false;
  List<Event> _events = [];

  @override
  void initState() {
    Event.getEvents()
      .then((List<Event> events) {
        setState(() {
          _is_ready = true;
          _is_error = false;
          _events = events;
        });
      })
      .catchError((err) {
        setState(() {
          _is_error = true;
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_is_error) {
      return Scaffold(
        // appBar: imageAppBar(),
          backgroundColor: Color(0xFF1F2631),
          body: Center(
            child: const Text("Something went wrong!", style: TextStyle(color: Colors.white))
          )
      );
    }

    if (!_is_ready) {
      return Scaffold(
        backgroundColor: Color(0xFF1F2631),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF1F2631),
      body: ListView(
        children: _events.map((Event e) => EventItem(event: e)).toList()
      )
    );
  }
}
