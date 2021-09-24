import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revent/models/commons.dart';

class Profile {
  String userUID = ""; // profile uuid
  String databaseID;

  DateTime birthday; // age verification
  DateTime registrated;

  List<Genre> favorites;
  Map<String, RequestStatus> friends = {};
  String qrToken = "";

  static final _profileRef =
      FirebaseFirestore.instance.collection('profile').withConverter<Profile>(
            fromFirestore: (snapshot, _) => Profile._fromJson(snapshot.data()),
            toFirestore: (profile, _) => profile._toJson(),
          );

  Profile._(this.birthday, {this.favorites = const [], this.friends}) {
    // This creates a 16 long string used for adding friends
    const _length = 16;
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    this.userUID = FirebaseAuth.instance.currentUser.uid;

    this.registrated = DateTime.now();

    this.qrToken = String.fromCharCodes(Iterable.generate(
        _length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Profile._fromJson(Map<String, Object> json) {
    this.userUID = json['user_uid'] as String;
    this.databaseID = json['id'] as String;
    this.registrated = DateTime.fromMillisecondsSinceEpoch(json['registrated']);
    this.birthday = DateTime.fromMillisecondsSinceEpoch(json['birthdate']);
    this.qrToken = json['qr_tokens'] as String;

    this.friends = (json['friends'] as Map<String, RequestStatus>).map((k, v) {
      return MapEntry('($k)', RequestStatus.values[v as int]);
    });

    this.favorites = (json['favorites'] as List<dynamic>)
        .map((e) => Genre.values[e as int])
        .toList();
  }

  Map<String, Object> _toJson() {
    return {
      'user_uid': this.userUID,
      'registrated': this.registrated.millisecondsSinceEpoch,
      'birthday': this.birthday.millisecondsSinceEpoch,
      'qr_tokens': this.qrToken,
      'friends': this.friends.map((k, v) {
        return MapEntry('($k)', v.index);
      }),
      'favorites': this.favorites.map((e) => e.index).toList(),
    };
  }

  Future<void> delete() async {
    return await _profileRef
        .doc(this.databaseID)
        .delete()
        .then((_) => print("Profile Deleted"))
        .catchError((error) => print("Failed to delete Profile: $error"));
  }

  static Future<Profile> create(birthday) async {
    Profile event = Profile._(birthday);
    event.save();

    return event;
  }

  Future<void> save() async {
    if (this.databaseID == null || this.databaseID.isEmpty) {
      await _profileRef.add(this).then((value) => this.databaseID = value.id);
    } else {
      await _profileRef.doc(this.databaseID).update(this._toJson());
    }
  }

  
  List<String> filter({type = RequestStatus::accepted}) async {
    List<String> acceptedFriends = [];
    
    friends.forEach((key, value) {
      if (value == type){	
	acceptedFriends.add(key);
      }
    });
    
    return acceptedFriends;
  }
}
