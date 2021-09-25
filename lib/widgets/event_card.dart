import 'package:flutter/material.dart';
import 'package:revent/models/event.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final Function actionClick;
  final Icon actionIcon;

  EventCard(this.event,
      {this.actionClick, this.actionIcon = const Icon(Icons.favorite)});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x000000),
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8),
                  BlendMode.dstATop,
                ),
                image: NetworkImage(widget.event.imgURL),
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.event.date.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  widget.event.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
              top: 12.5,
            ),
            child: RawMaterialButton(
              onPressed: widget.actionClick,
              elevation: 1.5,
              fillColor: Colors.white,
              child: Icon(
                widget.actionIcon.icon,
                size: 15.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
