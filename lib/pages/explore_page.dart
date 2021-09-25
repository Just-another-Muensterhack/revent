import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/event.dart';
import 'package:revent/pages/event_page.dart';
import 'package:revent/widgets/event_card.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Event> _events = [];

  void _fetchEvents() async {
    this._events = await Event.getEvents();
    setState(() {});
  }

  @override
  void initState() {
    this._fetchEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            height: 36,
            child: Align(
              alignment: Alignment.topLeft,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Genre.values.length,
                itemBuilder: (context, index) {
                  Genre genre = Genre.values[index];

                  return Container(
                    padding: const EdgeInsets.all(4.0),
                    height: 8,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(130, 81, 202, 1.0),
                      ),
                      child: Center(
                        child: Text(
                          genre.toString().split(".").last,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25.0,
                ),
                Text(
                  "Events",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: SizedBox(
                    height: 500.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: this._events.length,
                      itemBuilder: (context, index) {
                        Event event = this._events[index];

                        return Container(
                          width: 400,
                          height: 500,
                          padding: EdgeInsets.only(right: 40.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EventPage(event),
                              ),
                            ),
                            child: EventCard(event),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
