import 'package:revent/models/commons.dart';

List<String> filter(Map<String, RequestStatus> map,
    {RequestStatus type = RequestStatus.accepted}) {
  List<String> requestedSublist = [];

  map.forEach((key, value) {
    if (value == type) {
      requestedSublist.add(key);
    }
  });

  return requestedSublist;
}
