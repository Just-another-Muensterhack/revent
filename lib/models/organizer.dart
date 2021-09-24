import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revent/models/commons.dart';


class Organizer {
  String databaseID;
  String name;
  String address;
  String websiteURL;
  List<String> owners;	

  static final _orgranizerRef =
      FirebaseFirestore.instance.collection('organizer').withConverter<Organizer>(
            fromFirestore: (snapshot, _) => Organizer._fromJson(snapshot.data()),
            toFirestore: (organizer, _) => orgranizer._toJson(),
          );

  Organizer._(this.name, this.address, owner, {this.websiteURL = ""}) {
    this.owners.add(owner);
  }

  Profile._fromJson(Map<String, Object> json) {
    this.databaseID = json['id'] as String;
    this.name = json['name'] as String;
    this.address = json['address'] as String;
    this.websiteURL = json['websiteURL'] as String;
    this.favorites = json['owners'] as List<String>;
  }

  Map<String, Object> _toJson() {
    return {
      'id': this.databaseID,
      'name': this.name,
      'address': this.address,
      'websiteURL': this.websiteURL,
      'owners': this.owners,
    };
  }

  Future<void> delete() async {
    return await _profileRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Organizer Deleted"))
        .catchError((error) => print("Failed to delete Organizer: $error"));
  }

  static Future<Profile> create(name, address, owner) async {
    Profile event = Profile._(name, address, owner);
    event.save();

    return event;
  }

  Future<void> save() async {
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _orgranizerRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _orgranizerRef.doc(this.databaseID).update(this._toJson());
    }
  }
}
