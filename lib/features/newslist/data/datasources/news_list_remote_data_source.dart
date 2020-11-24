import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';

abstract class NewsListRemoteDataSource {
  Future<NewsResponse> getNewsList(String section, String apiKey);
}

class NewsListRemoteDataSourceImpl extends NewsListRemoteDataSource {
  final http.Client client;

  NewsListRemoteDataSourceImpl(this.client);

  @override
  Future<NewsResponse> getNewsList(String section, String apiKey) async {
    final response = await client.get(
        "https://api.nytimes.com/svc/topstories/v2/$section.json?api-key=$apiKey",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(utf8.decode(response.bodyBytes));
      return NewsResponse.fromJson(decodeData);
    } else {
      throw ServerException();
    }
  }
}
