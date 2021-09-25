import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/friend.dart';

class Profile {
  String userUID = ""; // profile uuid
  String databaseID= "";

  DateTime birthday; // age verification
  DateTime registrated;
  String displayName = "";
  String profileURL = "";

  List<Genre> favorites;
  List<Friend> friends = [];
  String qrToken = "";

  static final _databaseRef =
      FirebaseFirestore.instance.collection('profiles').withConverter<Profile>(
            fromFirestore: (snapshot, _) => Profile._fromJson(snapshot.data()),
            toFirestore: (profile, _) => profile._toJson(),
          );

  Profile._(this.displayName, this.profileURL, this.birthday) {
    this.userUID = FirebaseAuth.instance.currentUser.uid;
    this.registrated = DateTime.now();
    this.generateToken();
  }

  Profile._fromJson(Map<String, Object> json) {
    this.userUID = json['user_uid'] as String;
    this.databaseID = json['id'] as String;
    this.registrated = (json['registrated'] as Timestamp).toDate();
    this.birthday = (json['birthday'] as Timestamp).toDate();
    this.displayName = json['display_name'] as String;
    this.profileURL = json['profile_url'] as String;
    this.qrToken = json['qr_tokens'] as String;

    this.friends = (json['friends'] as List<dynamic>)
        .map((e) => Friend.fromJson(e))
        .toList();

    this.favorites = (json['favorites'] as List<dynamic>)
        .map((e) => Genre.values[e as int])
        .toList();
  }

  Map<String, Object> _toJson() {
    return {
      'user_uid': this.userUID,
      'registrated': this.registrated,
      'birthday': this.birthday,
      'display_name': this.displayName,
      'profile_url': this.profileURL,
      'qr_tokens': this.qrToken,
      'friends': this.friends.map((Friend e) => e.toJson()).toList(),
      'favorites': this.favorites.map((e) => e.index).toList(),
    };
  }

  void generateToken() {
    const _length = 16;
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    this.qrToken = String.fromCharCodes(Iterable.generate(
        _length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Future<void> delete() async {
    return await _databaseRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Profile Deleted"))
        .catchError((error) => print("Failed to delete Profile: $error"));
  }

  static Future<Profile> create(birthday) async {
    Profile profile = Profile._(
        FirebaseAuth.instance.currentUser.displayName,
        FirebaseAuth.instance.currentUser.photoURL,
        birthday);
    profile.save();

    return profile;
  }

  Future<void> save() async {
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _databaseRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _databaseRef.doc(this.databaseID).update(this._toJson());
    }
  }

  // filters friends and only returns a sublist of memberIDs that
  List<Friend> filterFriends({RequestStatus type = RequestStatus.accepted}) {
    return this.friends.where((element) => element.status == type).toList();
  }

  static Future<Profile> getByReference(String userUID) async {
    Profile profile;
    await _databaseRef
        .where('user_uid', isEqualTo: userUID)
        .limit(1)
        .get()
        .then((value) {
      profile = value.docs.first.data();
      profile.databaseID = value.docs.first.id;
    });

    return profile;
  }
}
