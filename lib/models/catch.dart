import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revent/models/Member.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/event.dart';
import 'package:revent/models/location.dart';

class Catch {
  static Catch mockCatch = Catch._([Event.mockEvent.databaseID]);

  String databaseID = "";
  List<String> events = [];
  List<Member> members = [];
  DateTime time = DateTime(2100);
  Location place = Location.mockAddress;

  // database connection via json serialize and deserialize
  static final _databaseRef =
      FirebaseFirestore.instance.collection('catches').withConverter<Catch>(
            fromFirestore: (snapshot, _) => Catch._fromJson(snapshot.data()),
            toFirestore: (project, _) => project._toJson(),
          );

  Catch._(this.events);

  // deserialize
  Catch._fromJson(Map<String, Object> json) {
    this.events = (json['events'] as List<dynamic>)
        .map((element) => element as String)
        .toList();
    this.members = (json['members'] as List<dynamic>)
        .map((e) => Member.fromJson(e))
        .toList();
    this.time = (json['time'] as Timestamp).toDate();
    this.place = Location.fromJson(json['place'] as Map<String, Object>);
  }

  // serialization
  Map<String, Object> _toJson() {
    return {
      'events': this.events,
      'members': this.members.map((Member e) => e.toJson()).toList(),
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

  List<Member> filterMembers({RequestStatus type = RequestStatus.accepted}) {
    return this.members.where((element) => element.status == type);
  }

  static Future<Catch> getByReference(String catchID) async {
    Catch catchObject;
    await _databaseRef
        .doc(catchID)
        .get()
        .then((value) {
      catchObject = value.data();
      catchObject.databaseID = value.id;
    });

    return catchObject;
  }

  RequestStatus myStatus() {
    String myUserUID = FirebaseAuth.instance.currentUser.uid;
    return members
        .where((element) => element.userUID == myUserUID)
        .first
        .status;
  }
}
