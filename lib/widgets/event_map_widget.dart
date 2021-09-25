import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:revent/models/event.dart';

class EventMapWidget extends StatefulWidget {
  final List<Event> events;

  EventMapWidget(this.events, {Key key}) : super(key: key);

  @override
  State<EventMapWidget> createState() => EventMapWidgetState();
}

class EventMapWidgetState extends State<EventMapWidget> {

  List<Marker> markers = <Marker>[];
  List<Event> events;

  //EventMapWidgetState({Key key}) : super(key: key);

  void _generateMarker(){
    this.events = this.widget.events;
    setState(() {
      this.markers = events.map(
              (Event e) => Marker(
                markerId: MarkerId(e.title),
                position: LatLng(
                    e.eventLocation.latitude,
                    e.eventLocation.longitude
                ),
                infoWindow: InfoWindow(
                  title: e.title,
                  snippet: e.description,
                ),
              )
          ).toList();
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _startPosition = CameraPosition(
    target: LatLng(51.9606649, 7.6261347),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _startPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _generateMarker();
        },
        markers: Set<Marker>.of(this.markers),
        buildingsEnabled: false,
      ),
    );
  }
}