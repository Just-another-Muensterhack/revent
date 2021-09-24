import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/location.dart';

class Catch {
  String databaseID;
  List<String> events = [];
  Map<String, RequestStatus> members = {};
  DateTime time;
  Location place;

  // database connection via json serialize and deserialize
  static final _databaseRef =
      FirebaseFirestore.instance.collection('catch').withConverter<Catch>(
            fromFirestore: (snapshot, _) => Catch._fromJson(snapshot.data()),
            toFirestore: (project, _) => project._toJson(),
          );

  Catch._(this.events, {this.members, this.time, this.place});

  // deserialize
  Catch._fromJson(Map<String, Object> json) {
    this.events = (json['events'] as List<dynamic>)
        .map((element) => element as String)
        .toList();
    this.members = (json['members'] as Map<String, RequestStatus>).map((k, v) {
      return MapEntry('($k)', RequestStatus.values[v as int]);
    });
    this.time = json['time'] as DateTime;
    this.place = Location.fromJson(json['place'] as Map<String, Object>);
    this.databaseID = json['id'] as String;
  }

  // serialization
  Map<String, Object> _toJson() {
    return {
      'events': this.events,
      'members': this
          .members
          .map((String key, RequestStatus value) => MapEntry(key, value.index)),
      'time': this.time,
      'place': this.place.toJson(),
    };
  }

  //check functionality
  Future<List<Catch>> getCatches() async {
    List<Catch> events = [];
    await _databaseRef
        .where('members', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        Catch tmp = document.data();
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
  static Future<Catch> create(events) async {
    Catch event = Catch._(events);
    event.save();

    return event;
  }

  // delete
  Future<void> delete() async {
    return await _databaseRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Catch Deleted"))
        .catchError((error) => print("Failed to delete Catch: $error"));
  }
}
