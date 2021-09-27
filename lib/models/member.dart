import 'package:revent/models/commons.dart';

class Member {
  String userUID = "";
  RequestStatus status = RequestStatus.accepted;

  Member(this.userUID,
      this.status);

  Member.fromJson(Map<String, Object> json) {
    this.userUID = json['user_uid'] as String;
    this.status = RequestStatus.values[json['status'] as int];
  }

  Map<String, Object> toJson() {
    return {
      'user_uid': this.userUID,
      'status': this.status.index,
    };
  }
}