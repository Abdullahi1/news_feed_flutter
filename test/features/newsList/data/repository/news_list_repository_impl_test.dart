import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/core/error/failures.dart';
import 'package:new_feed/core/network/network_info.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_local_data_source.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_remote_data_source.dart';
import 'package:new_feed/features/newslist/data/mapper/multimedia_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/news_response_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/result_mapper.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';
import 'package:new_feed/features/newslist/data/repositories/news_list_repository_impl.dart';
import 'package:new_feed/features/newslist/domain/repository/news_list_repository.dart';
import 'package:new_feed/features/newslist/domain/usecases/get_news_list_use_case.dart';

import '../../../../testData/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalDataSource extends Mock implements NewsListLocalDataSource {}

class MockRemoteDataSource extends Mock implements NewsListRemoteDataSource {}

void main() {
  MockNetworkInfo mockNetworkInfo;
  MockLocalDataSource localDataSource;
  MockRemoteDataSource remoteDataSource;
  NewsListRepository repository;

  MultimediaMapper multimediaMapper;
  ResultMapper resultMapper;
  NewsResponseMapper newsResponseMapper;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    localDataSource = MockLocalDataSource();
    remoteDataSource = MockRemoteDataSource();

    multimediaMapper = MultimediaMapper();
    resultMapper = ResultMapper(multimediaMapper);
    newsResponseMapper = NewsResponseMapper(resultMapper);

    repository = NewsListRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: mockNetworkInfo,
        mapper: newsResponseMapper);
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("get news list", () {
    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    //final NewsEntity entity = newsResponseMapper.to(response);

    final newsParam = Params(section: "home", apiKey: "mdlddosnonsos");

    test("Should Check if the device is online", () async {
      //given that the device is online
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //when the network call is made
      final result = await mockNetworkInfo.isConnected;

      //verify the result is true
      expect(true, result);
    });

    test("call network info before init", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getNewsList(newsParam.section, newsParam.apiKey);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test("should return the remote data when the request is successful",
          () async {
        when(remoteDataSource.getNewsList(any, any))
            .thenAnswer((_) async => response);

        final result =
            await repository.getNewsList(newsParam.section, newsParam.apiKey);

        verify(
            remoteDataSource.getNewsList(newsParam.section, newsParam.apiKey));
        expect(result, equals(Right(newsResponseMapper.to(response))));
      });

      test("should cache the remote data when the request is successful",
          () async {
        when(remoteDataSource.getNewsList(any, any))
            .thenAnswer((_) async => response);

        await repository.getNewsList(newsParam.section, newsParam.apiKey);

        verify(
            remoteDataSource.getNewsList(newsParam.section, newsParam.apiKey));
        verify(localDataSource.insertNews(response));
      });

      test(
          "should throw server failure when the remote data when the request is unsuccessful",
          () async {
        when(remoteDataSource.getNewsList(any, any))
            .thenThrow(ServerException());

        final result =
            await repository.getNewsList(newsParam.section, newsParam.apiKey);

        verify(
            remoteDataSource.getNewsList(newsParam.section, newsParam.apiKey));
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          "should return the last local data when the request is not successful",
          () async {
        when(localDataSource.getNewsList(newsParam.section))
            .thenAnswer((_) async => response);

        final result =
            await repository.getNewsList(newsParam.section, newsParam.apiKey);

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getNewsList(newsParam.section));
        expect(result, equals(Right(newsResponseMapper.to(response))));
      });

      test("should return failure when there is no cached data present",
          () async {
        when(localDataSource.getNewsList(newsParam.section))
            .thenThrow(CacheException());

        final result =
            await repository.getNewsList(newsParam.section, newsParam.apiKey);

        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getNewsList(newsParam.section));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
