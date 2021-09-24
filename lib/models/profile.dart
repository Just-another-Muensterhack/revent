import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoom_app/services/auth_service.dart';
import 'commons.dart';

class Profile {
  String user_uid = ""; // profile uuid

  Date brithday; // age verification
  Date registrated; 

  List<Genre> favorites = [];
  List<String> friends = {};
  String qr_token = "";

  static final _profileRef =
      FirebaseFirestore.instance.collection('profile').withConverter<Profile>(
            fromFirestore: (snapshot, _) => Profile._fromJson(snapshot.data()),
            toFirestore: (profile, _) => profile._toJson(),
          );

  Project._() {
    // This creates a 16 long string used for adding friends 
    const _length = 16;
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    qr_token = String.fromCharCodes(Iterable.generate(_length, (_) => 
	_chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    
    user_uid = firebase.auth().currentUser.uid;
  };

  Project._fromJson(Map<String, Object> json) {
    this.user_uid = json['user_uid'] as String;
    this.registrated = DateTime.fromMillisecondsSinceEpoch(json['registrated']);
    this.birthday = DateTime.fromMillisecondsSinceEpoch(json['birthdate']);
    this.qr_token = json['qr_tokens'] as String;	

    this.friends =
        (json['friends'] as Map<String, RequestStatus>).map((k, v) {
		return MapEntry('($k)', RequestStatus.values[v as int];
	}).toMap();
    
    this.favorites =
        (json['favorites'] as List<dynamic>).map((e) => Genre.values[e as int] ).toList();
    
  }

  Map<String, Object> _toJson() {
    return {
      'user_uid': this.user_uid,
      'registrated': this.registrated.millisecondsSinceEpoch,
      'birthday': this.birthday.millisecondsSinceEpoch,
      'qr_tokens': this.qr_tokens,
      'friends': this.friends.map((k, v) {
        return MapEntry('($k)', v.index);
      }).toMap(),
      'favorites': this.friends.map((e) => e.index).toList(),
    };
  }

  Future<void> delete() async {
    return await _profileRef
        .doc(this.user_uid)
        .delete()
        .then((_) => print("Profile Deleted"))
        .catchError((error) => print("Failed to delete Profile: $error"));
  }

  Future<void> save() async {
    if (this.user_uid == null || this.user_uid.isEmpty) {
      await _profileRef.add(this).then((value) => this.user_uid = value.user_uid);
    } else {
      await _profileRef.doc(this.user_uid).update(this._toJson());
    }
  }
}
