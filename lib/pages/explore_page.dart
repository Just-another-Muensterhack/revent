import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/event.dart';
import 'package:revent/pages/create_catch_page.dart';
import 'package:revent/pages/event_page.dart';
import 'package:revent/services/search_service.dart';
import 'package:revent/widgets/event_card.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Event> _events = [];
  TextEditingController txt = TextEditingController();

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
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: ListView(
        children: [
          TextField(
            controller: txt,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Color.fromRGBO(130, 81, 202, 1.0), width: 4.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Color.fromRGBO(130, 81, 202, 1.0), width: 4.0),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 12, 0),
                child: Icon(Icons.search, color: Colors.white),
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                padding: EdgeInsets.only(right: 10.0),
                onPressed: () async {
                  this._fetchEvents();
                  txt.clear();
                },
                icon: Icon(Icons.clear, color: Colors.white),
              ),
            ),
            cursorColor: Colors.white,
            textInputAction: TextInputAction.go,
            onSubmitted: (term) {
              print(term);
              SearchService.searchEvent(term, []).then((ids) {
                this._events = [];

                ids.forEach((id) async {
                  Event event = await Event.getByReference(id);
                  _events.add(event);
                  setState(() {});
                });
              });
            },
          ),
          Container(height: 10),
          Container(
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
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(130, 81, 202, 1.0),
                          ),
                          child: Center(
                              child: Text(
                                  genre
                                          .toString()
                                          .substring(6, 7)
                                          .toUpperCase() +
                                      genre.toString().substring(7),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700)))));
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Events",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              this._events.isEmpty
                  ? Center(child: Text("No events found."))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: this._events.length,
                        itemBuilder: (context, index) {
                          Event event = this._events[index];

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            padding: EdgeInsets.only(right: 20.0),
                            child: InkWell(
                              onDoubleTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateCatchPage([event]),
                                ),
                              ),
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
            ],
          ),
        ],
      ),
    );
  }
}
