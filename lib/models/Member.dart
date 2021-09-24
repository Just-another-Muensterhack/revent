import 'package:revent/models/commons.dart';

class Member {
  String userUID = "";
  RequestStatus status = RequestStatus.accepted;

  Member(this.userUID,
      this.status);

  Member.fromJson(Map<String, Object> json) {
    this.userUID = json['userUsID'] as String;
    this.status = RequestStatus.values[json['status'] as int];
  }

  Map<String, Object> toJson() {
    return {
      'userUID': this.userUID,
      'status': this.status.index,
    };
  }
}