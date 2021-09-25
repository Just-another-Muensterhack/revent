import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchService {
  static init() {}

  static Future<List<String>> searchEvent(String term, List<int> genre) async {
    if (term.isEmpty) {
      term = '*';
    }

    String uri = "https://europe-west3-revent-2ce19.cloudfunctions.net/search";
    Map<String, dynamic> data = {'term': term};

    if (genre.isNotEmpty) {
      data["genre"] = genre;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final res = await http.post(Uri.parse(uri),
        headers: headers, body: json.encode(data));

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      List<String> ids = [];
      (json.decode(res.body)["response"]['docs'] as List<dynamic>)
          .forEach((element) {
        ids.add(element['id'] as String);
      });
      return ids;
    } else {
      return [] as List<String>;
    }
  }
}

// var url = "https://someurl/here";
// var body = json.encode({"foo": "bar"});
//
// Map<String,String> headers = {
//   'Content-type' : 'application/json',
//   'Accept': 'application/json',
// };
//
// final response =
// http.post(url, body: body, headers: headers);
// final responseJson = json.decode(response.body);
