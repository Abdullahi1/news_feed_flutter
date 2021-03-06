import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_remote_data_source.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';

import '../../../../testData/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  NewsListRemoteDataSource remoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = NewsListRemoteDataSourceImpl(mockHttpClient);
  });

  group("Get News List", () {
    final tSection = "home";
    final tApiKey = "23kdnidsisdn";

    test(
        "should perform a GET request on a URL with number being the endpoint and with application/json header",
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
              utf8.decode(await fixtureAsByte('newsData.json')), 200));

      remoteDataSource.getNewsList(tSection, tApiKey);

      verify(mockHttpClient.get(
          "https://api.nytimes.com/svc/topstories/v2/$tSection.json?api-key=$tApiKey",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
    });

    test(
        "Should return instance of News Response Object when the response code is 200",
            () async {
          when(mockHttpClient.get(any, headers: anyNamed('headers')))
              .thenAnswer(
                  (_) async => http.Response(
                  utf8.decode(await fixtureAsByte('newsData.json')), 200));

          final result = await remoteDataSource.getNewsList(tSection, tApiKey);

          expect(result, isA<NewsResponse>());
        });

    test("Should throw server error when the response code is 404 or others",
        () {
          when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Something went wrong", 404));

      final result = remoteDataSource.getNewsList;

      expect(() => result(tSection, tApiKey), throwsA(isA<ServerException>()));
    });
  });
}
