import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_feed/model/NewsResponse.dart';

class NetworkHelper {
  final String sectionName;
  final String apiKey;

  NetworkHelper({this.sectionName, this.apiKey});

  Future<NewsResponse> getNewsData() async {
    final response = await http.get(
        "https://api.nytimes.com/svc/topstories/v2/$sectionName?api-key=$apiKey");

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      return NewsResponse.fromJson(decodeData);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
