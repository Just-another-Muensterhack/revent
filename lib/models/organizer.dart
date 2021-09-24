import 'package:cloud_firestore/cloud_firestore.dart';

class Organizer {
  String databaseID;
  String name;
  String address;
  String websiteURL;
  List<String> owners;

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
    this.databaseID = json['id'] as String;
    this.name = json['name'] as String;
    this.address = json['address'] as String;
    this.websiteURL = json['websiteURL'] as String;
    this.owners = json['owners'] as List<String>;
  }

  Map<String, Object> _toJson() {
    return {
      'name': this.name,
      'address': this.address,
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
      await _databaseRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _databaseRef.doc(this.databaseID).update(this._toJson());
    }
  }

  static Future<Organizer> getByReference(String organizerRef) async {
    Organizer organizer;
    await _databaseRef
        .where('id', isEqualTo: organizerRef)
        .limit(1)
        .get()
        .then((value) => organizer = value.docs.first.data());

    return organizer;
  }
}
