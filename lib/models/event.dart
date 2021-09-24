import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revent/models/location.dart';

class Event {
  String databaseID;
  String organizerRef;
  String title;
  String description;
  DateTime date;
  List<Genre> genre = [];
  Price price_class = Price.CHEAP;
  String img_url;
  Location event_location;

  // List<Video-Format> clip  <= TODO implement later
  String website_url;

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
      this.price_class,
      this.img_url,
      this.event_location,
      this.website_url);

  // deserialize
  Event._fromJson(Map<String, Object> json) {
    this.organizerRef = json['organizerRef'] as String;
    this.title = json['title'] as String;
    this.description = json['longitude'] as String;
    this.date = json['date'] as DateTime;
    this.genre = (json['genre'] as List<dynamic>)
        .map((e) => Genre.values[e as int])
        .toList();
    this.price_class = Price.values[json['price_class'] as int];
    this.img_url = json['img_url'] as String;
    this.event_location =
        Location.fromJson(json['img_url'] as Map<String, Object>);
  }

  // serialization
  Map<String, Object> _toJson() {
    return {
      'organizerRef': this.organizerRef == null ? "" : this.organizerRef,
      'title': this.title,
      'description': this.description,
      'date': this.date,
      'genre': this.genre,
      'price_class': this.price_class,
      'img_url': this.img_url,
      'event_location': this.event_location,
      'website_url': this.website_url,
    };
  }

  //check functionality
  Future<List<Event>> getEvents() async {
    List<Event> events = [];
    await _databaseRef
        .where('date', isGreaterThan: this.date)
        .where('genre', whereIn: this.genre)
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        Event tmp = document.data();
        //print("For each:" + document.id);
        tmp.databaseID = document.id;
        events.add(tmp);
      });
    });
    return events;
  }

  Future<void> save() async {
    //print(this.projectOwners);
    //print("ID: " + this.id);
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _databaseRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _databaseRef.doc(this.databaseID).update(this._toJson());
    }
  }

  // static create
  static Future<Event> create(organizerRef, title, description, date, genre,
      price_class, img_url, event_location, website_url) async {
    Event event = Event._(organizerRef, title, description, date, genre,
        price_class, img_url, event_location, website_url);
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
}
