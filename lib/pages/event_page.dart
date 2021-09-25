import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revent/models/event.dart';

class _EventHeader extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EventHeaderState();
}

class _EventHeaderState extends State<_EventHeader>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Henri_Rousseau_%28French%29_-_A_Centennial_of_Independence_-_Google_Art_Project.jpg/1280px-Henri_Rousseau_%28French%29_-_A_Centennial_of_Independence_-_Google_Art_Project.jpg'),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}

class _EventContainer extends StatefulWidget{
  final Event event;

  _EventContainer(this.event, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventContainerState();

}

class _EventContainerState extends State<_EventContainer>{
  Event event;

  final SizedBox _spacer = SizedBox(height: 10,);

  final TextStyle _header1Style = new TextStyle(
    color: Colors.white,
    fontFamily: "Poppins",
    fontWeight: FontWeight.bold,
  );

  final TextStyle _infoStyle = new TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: "Poppins",
  );

  final TextStyle _genericText = new TextStyle(
    color: Colors.white,
    fontFamily: "Poppins",
  );

  final TextStyle _textButtonText = new TextStyle(
    color: Colors.deepPurpleAccent,
    fontSize: 10,
    fontFamily: "Poppins",
  );

  @override
  Widget build(BuildContext context) {
    this.event = this.widget.event;

    DateFormat dateFormater = DateFormat("dd. MM. y");
    DateFormat timeFormater = DateFormat.Hm();

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(children: [Text(this.event.title, style: _header1Style,)],),
                    Column(
                      children: [
                        Wrap(children: [
                          Icon(Icons.calendar_today, color: Colors.white,),
                          Text(dateFormater.format(this.event.date), style: _infoStyle,)
                        ],),
                        Wrap(children: [
                          Icon(Icons.watch_later_outlined, color: Colors.white,),
                          Text(timeFormater.format(this.event.date), style: _infoStyle,)
                        ],)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Wrap(children: [
            Text("Description", style: _header1Style,),
          ],),
          _spacer,
          Wrap(children: [
            Text(this.event.description, style: _genericText,)
          ],),
          _spacer,
          Wrap(children: [
            TextButton(
              onPressed: () => {print("read more")},
              child: Text("read more...", style: _textButtonText,),
            )
          ],),
          _spacer,
          Wrap(children: [
            Text("Friends", style: _header1Style,)
          ],),
          _spacer,
          ElevatedButton(
            onPressed: () => {print("reserve ticket")},
            child: Text("reserve a ticket"),
          ),
          TextButton(
              onPressed: () => {},
              child: Text("reserve a ticket")
          )
        ],
      ),
    );
  }

}

class EventPage extends StatefulWidget{
  final Event event;

  EventPage(this.event, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventPageState();

}

class _EventPageState extends State<EventPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          _EventHeader(),
          _EventContainer(this.widget.event),
        ],
      ),
    );
  }

}