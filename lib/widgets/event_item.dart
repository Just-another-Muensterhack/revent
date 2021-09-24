import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/models/event.dart';

class EventItem extends StatelessWidget {
  EventItem({ Key key, this.event }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image(image: NetworkImage(event.imgURL))
      ),
      title: Text(event.title, style: TextStyle(color: Colors.white)),
      subtitle: Text(event.description, style: TextStyle(color: Colors.white)),
      trailing: OutlinedButton(
        onPressed: () => { print('pressed ${event.databaseID}') },
        child: const Text('join now'),
        style: ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white))
      )
    );
  }
}