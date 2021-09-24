import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/models/event.dart';
import 'package:revent/widgets/event_item.dart';

class CatchPage extends StatefulWidget {
  _CatchPageState createState() => _CatchPageState();
}

class _CatchPageState extends State<CatchPage> {
  bool _isReady = false;
  bool _isError = false;
  List<Event> _events = [];

  @override
  void initState() {
    Event.getEvents()
      .then((List<Event> events) {
        setState(() {
          _isReady = true;
          _isError = false;
          _events = events;
        });
      })
      .catchError((err) {
        setState(() {
          _isError = true;
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Scaffold(
        // appBar: imageAppBar(),
          backgroundColor: Color(0xFF1F2631),
          body: Center(
            child: const Text("Something went wrong!", style: TextStyle(color: Colors.white))
          )
      );
    }

    if (!_isReady) {
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
