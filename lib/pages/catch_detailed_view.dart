import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/catch.dart';
import 'package:revent/models/event.dart';

class CatchDetailedView extends StatelessWidget {
  final String catchID;

  CatchDetailedView({this.catchID = "Swyon3hSoA3tXGMvxCK9"});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.white12,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: Text(
                "Back",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        backgroundColor: primary,
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              Catch cat = snapshot.data as Catch;
              return ListView(
                padding: EdgeInsets.all(15),
                children: [
                  Container(
                    height: size.height * 0.2,
                    child: FutureBuilder(
                      builder: (contextImg, snapshotImg) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else if (snapshotImg.data != null) {
                          Event event = snapshotImg.data as Event;
                          print(event);
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      image: NetworkImage(event.imgURL),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        event.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Text(
                                          event.description,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text("all failed");
                        }
                      },
                      future: Event.getByReference(cat.events.first),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Icon(
                              Icons.event_note_sharp,
                              color: Colors.white,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(cat.time.day.toString().padLeft(2, "0") +
                                ":" +
                                cat.time.month.toString().padLeft(2, "0") +
                                ":" +
                                cat.time.year.toString().padLeft(4, "0")),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(cat.time.hour.toString().padLeft(2, "0") +
                                ":" +
                                cat.time.minute.toString().padLeft(2, "0")),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      cat.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      cat.description,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              );
            }
          },
          future: Catch.getByReference(catchID),
        ));
  }
}
