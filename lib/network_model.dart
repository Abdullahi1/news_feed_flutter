import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String sectionName;
  final String apiKey;

  NetworkHelper({this.sectionName, this.apiKey});

  Future getNewsData() async {
    http.Response response = await http.get(
        "https://api.nytimes.com/svc/topstories/v2/$sectionName?api-key=$apiKey");

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      var result = decodeData["results"] as List;
      return result;
    }
  }
}
