import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/db/news_dao.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_local_data_source.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';

import '../../../../testData/fixture_reader.dart';

class MockNewsResponseDao extends Mock implements NewsDao {}

void main() {
  NewsListLocalDataSource localDataSource;
  MockNewsResponseDao newsResponseDao;

  setUp(() {
    newsResponseDao = MockNewsResponseDao();
    localDataSource = NewsListLocalDataSourceImpl(newsResponseDao);
  });

  group("Get News List", () {
    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    test("Should return news response from the database when there is data",
        () async {
      when(newsResponseDao.getNewsResponse(any))
          .thenAnswer((_) async => response);

      final result = await localDataSource.getNewsList("home");

      verify(newsResponseDao.getNewsResponse("home"));
      expect(result, equals(response));
    });

    test("Should throw error if there is no data from the database", () async {
      when(newsResponseDao.getNewsResponse(any)).thenAnswer((_) async => null);

      final call = localDataSource.getNewsList;

      expect(() => call("home"), throwsA(isA<CacheException>()));
    });
  });

  group("Insert News", () {
    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    test(
        "Should insert news response into the database when transaction is successful",
        () async {
      await localDataSource.insertNews(response);

      verify(newsResponseDao.insertNews(response));
    });
  });

  group("Delete News", () {
    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    test(
        "Should delete news response into the database when transaction is successful",
        () async {
      await localDataSource.deleteNews("home");

      verify(newsResponseDao.deleteSection("home"));
    });
  });
}
