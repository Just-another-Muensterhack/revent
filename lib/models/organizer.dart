import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revent/models/location.dart';

class Organizer {
  static Organizer mockOrganizer =
      Organizer._("Lustiger Nae", Location.mockAddress, "dsg");

  String databaseID = "";
  String name = "";
  Location address;
  String websiteURL = "";
  List<String> owners = [];

  static final _databaseRef = FirebaseFirestore.instance
      .collection('organizer')
      .withConverter<Organizer>(
        fromFirestore: (snapshot, _) => Organizer._fromJson(snapshot.data()),
        toFirestore: (organizer, _) => organizer._toJson(),
      );

  Organizer._(this.name, this.address, owner, {this.websiteURL = ""}) {
    this.owners.add(owner);
  }

  Organizer._fromJson(Map<String, Object> json) {
    this.name = json['name'] as String;
    this.address = Location.fromJson(json['address']);
    this.websiteURL = json['websiteURL'] as String;
    this.owners =
        (json['owners'] as List<dynamic>).map((e) => e as String).toList();
  }

  Map<String, Object> _toJson() {
    return {
      'name': this.name,
      'address': this.address.toJson(),
      'websiteURL': this.websiteURL,
      'owners': this.owners,
    };
  }

  Future<void> delete() async {
    return await _databaseRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Organizer Deleted"))
        .catchError((error) => print("Failed to delete Organizer: $error"));
  }

  static Future<Organizer> create(name, address, owner) async {
    Organizer organizer = Organizer._(name, address, owner);
    organizer.save();

    return organizer;
  }

  Future<void> save() async {
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _databaseRef.add(this).then((value) {
        this.databaseID = value.id;
      });
    } else {
      await _databaseRef.doc(this.databaseID).update(this._toJson());
    }
  }

  static Future<Organizer> getByReference(String organizerRef) async {
    Organizer organizer;
    await _databaseRef.doc(organizerRef).get().then((value) {
      organizer = value.data();
      organizer.databaseID = value.id;
    });

    return organizer;
  }
}
