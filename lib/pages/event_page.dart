import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/event.dart';
import 'package:revent/models/organizer.dart';
import 'package:revent/pages/create_catch_page.dart';
import 'package:url_launcher/url_launcher.dart';

class _EventHeader extends StatefulWidget {
  final String imageUrl;

  _EventHeader(this.imageUrl);

  @override
  State<StatefulWidget> createState() => _EventHeaderState();
}

class _EventHeaderState extends State<_EventHeader> {
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
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            image: NetworkImage(widget.imageUrl),
          ),
        ),
      ),
    );
  }
}

class _EventContainer extends StatefulWidget {
  final Event event;

  _EventContainer(this.event, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventContainerState();
}

class _EventContainerState extends State<_EventContainer> {
  Event event;
  Organizer organizer;

  @override
  void initState() {
    super.initState();

    this.event = this.widget.event;
    if (this.event != null) {
      Organizer.getByReference(this.event.organizerRef).then((organizer) {
        this.organizer = organizer;

        setState(() {});
      });
    }
  }

  final TextStyle _header1Style = new TextStyle(
    fontSize: 25.0,
  );

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormater = DateFormat("dd.MM.y");
    DateFormat timeFormater = DateFormat.Hm();

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: this.organizer != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: Text(
                        this.event.title,
                        style: _header1Style,
                      ),
                    ),
                    ListTile(
                      title: Text(this.event.description),
                    ),
                    ListTile(
                      title: Text(dateFormater.format(this.event.date)),
                      subtitle:
                          Text(timeFormater.format(this.event.date) + " pm"),
                      leading: Icon(
                        Icons.event,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.white),
                      title: Text(organizer.name),
                      subtitle: Text("Organizer"),
                    ),
                    ListTile(
                      leading: Icon(Icons.web, color: Colors.white),
                      title: Text(organizer.websiteURL),
                      subtitle: Text("Website"),
                      trailing: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.open_in_browser),
                        onPressed: () async {
                          String url = this.organizer.websiteURL;
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceSafariVC: true,
                              forceWebView: true,
                              enableJavaScript: true,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(this
                          .event
                          .genre
                          .map((e) =>
                              "#" + e.toString().split(".").last.toLowerCase())
                          .join(" ")),
                      leading: Icon(
                        Icons.label_important_outline,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.euro,
                        color: Colors.white,
                      ),
                      title: Text(
                        this
                            .event
                            .priceClass
                            .toString()
                            .split(".")
                            .last
                            .toLowerCase(),
                      ),
                      subtitle: Text("Pricing"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      title: Text(this.event.eventLocation.street +
                          " " +
                          this.event.eventLocation.houseNumber),
                      subtitle: Text(
                          this.event.eventLocation.postalCode.toString() +
                              " " +
                              this.event.eventLocation.city +
                              ", " +
                              this.event.eventLocation.country),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          String latitude =
                              this.event.eventLocation.latitude.toString();
                          String longitude =
                              this.event.eventLocation.latitude.toString();
                          String googleUrl =
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                          if (await canLaunch(googleUrl)) {
                            await launch(googleUrl);
                          } else {
                            throw 'Could not open the map.';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Center(
                  child: Container(
                    width: 200.0,
                    child: TextButton(
                      child: const Text(
                        "catch it!",
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
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCatchPage([this.event]),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 25.0,
                ),
              ],
            )
          : Container(),
    );
  }
}

class EventPage extends StatefulWidget {
  final Event event;

  EventPage(this.event, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          _EventHeader(widget.event.imgURL),
          _EventContainer(this.widget.event),
        ],
      ),
    );
  }
}
