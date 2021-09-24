import 'package:flutter/material.dart';
import 'package:revent/filters/color_filters.dart';
import 'package:revent/models/event.dart';

class EventCard extends StatelessWidget{

  Event event;

  EventCard({Key key, Event event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Ink.image(
              image: NetworkImage(
                event.imgURL,
              ),
              colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {},
              ),
              height: 500,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    event.date.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    event.title,
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
              padding: EdgeInsets.all(5),
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 1.5,
                fillColor: Colors.white,
                child: Icon(
                    Icons.favorite,
                    size: 15.0,
                    color: Theme.of(context).colorScheme.secondary
                ),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}