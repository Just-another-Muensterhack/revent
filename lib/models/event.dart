import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/location.dart';

class Event {
  String databaseID;
  String organizerRef;
  String title;
  String description;
  DateTime date;
  List<Genre> genre = [];
  Price priceClass = Price.cheap;
  String imgURL;
  Location eventLocation;

  // List<Video-Format> clip  <= TODO implement later
  String websiteURL;

  // database connection via json serialize and deserialize
  static final _databaseRef =
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
            fromFirestore: (snapshot, _) => Event._fromJson(snapshot.data()),
            toFirestore: (project, _) => project._toJson(),
          );

  Event._(
      this.organizerRef,
      this.title,
      this.description,
      this.date,
      this.genre,
      this.priceClass,
      this.imgURL,
      this.eventLocation,
      this.websiteURL);

  // deserialize
  Event._fromJson(Map<String, Object> json) {
    this.organizerRef = json['organizerRef'] as String;
    this.title = json['title'] as String;
    this.description = json['description'] as String;
    this.date = (json['date'] as Timestamp).toDate();
    this.genre = (json['genre'] as List<dynamic>)
        .map((e) => Genre.values[e as int])
        .toList();
    this.priceClass = Price.values[json['price_class'] as int];
    this.imgURL = json['img_url'] as String;
    this.eventLocation = Location.fromJson(json['event_location']);
  }

  // serialization
  Map<String, Object> _toJson() {
    return {
      'organizerRef': this.organizerRef,
      'title': this.title,
      'description': this.description,
      'date': this.date,
      'genre': this.genre.map((Genre e) => e.index).toList(),
      'price_class': this.priceClass.index,
      'img_url': this.imgURL,
      'event_location': this.eventLocation.toJson(),
      'website_url': this.websiteURL,
    };
  }

  //check functionality
  static Future<List<Event>> getEvents() async {
    List<Event> events = [];
    await _databaseRef
        .where('date', isGreaterThan: DateTime.now())
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        Event tmp = document.data();
        tmp.databaseID = document.id;
        events.add(tmp);
      });
    });
    return events;
  }

  Future<void> save() async {
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _databaseRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _databaseRef.doc(this.databaseID).update(this._toJson());
    }
  }

  // static create
  static Future<Event> create(organizerRef, title, description, date, genre,
      priceClass, imgURL, eventLocation, websiteURL) async {
    Event event = Event._(organizerRef, title, description, date, genre,
        priceClass, imgURL, eventLocation, websiteURL);
    event.save();

    return event;
  }

  // delete
  Future<void> delete() async {
    return await _databaseRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Event Deleted"))
        .catchError((error) => print("Failed to delete Event: $error"));
  }

  static Future<Event> getByReference(String eventID) async {
    Event event;
    await _databaseRef.doc(eventID).get().then((value) {
      event = value.data();
      event.databaseID = value.id;
    });

    return event;
  }
}
