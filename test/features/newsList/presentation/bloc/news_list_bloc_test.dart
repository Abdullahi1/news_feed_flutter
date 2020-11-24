import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_feed/core/error/failures.dart';
import 'package:new_feed/features/newslist/data/mapper/multimedia_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/news_response_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/result_mapper.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';
import 'package:new_feed/features/newslist/domain/usecases/get_news_list_use_case.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_bloc.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_event.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_state.dart';

import '../../../../testData/fixture_reader.dart';

class MockGetNewsListUseCase extends Mock implements GetNewsListUseCase {}

void main() {
  MockGetNewsListUseCase newsListUseCase;
  NewsPostBloc newsPostBloc;

  MultimediaMapper multimediaMapper;
  ResultMapper resultMapper;
  NewsResponseMapper newsResponseMapper;

  setUp(() {
    newsListUseCase = MockGetNewsListUseCase();

    newsPostBloc = NewsPostBloc(getNewsListUseCase: newsListUseCase);

    multimediaMapper = MultimediaMapper();
    resultMapper = ResultMapper(multimediaMapper);
    newsResponseMapper = NewsResponseMapper(resultMapper);
  });

  test("Initial State Should be NewsPostInitial", () {
    expect(newsPostBloc.state, equals(NewsPostInitial()));
  });

  group("News Post Fetch Event", () {
    multimediaMapper = MultimediaMapper();
    resultMapper = ResultMapper(multimediaMapper);
    newsResponseMapper = NewsResponseMapper(resultMapper);

    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    final newsParam = Params(section: "home", apiKey: "mdlddosnonsos");

    blocTest("should get data from the get news list use case",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Right(newsResponseMapper.to(response)));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewsPostFetched(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        verify: (bloc) => newsListUseCase(newsParam));

    blocTest("should emit [NewsPostSuccess] when data is gotten successfully",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Right(newsResponseMapper.to(response)));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewsPostFetched(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [NewsPostSuccess(newsPost: newsResponseMapper.to(response))]);

    blocTest(
        "should emit [NewsPostFailure] when data is not gotten from server",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewsPostFetched(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [NewsPostFailure()]);

    blocTest("should emit [NewsPostFailure] when data is not gotten from cache",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewsPostFetched(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [NewsPostFailure()]);
  });

  group("News Post Refresh Event", () {
    multimediaMapper = MultimediaMapper();
    resultMapper = ResultMapper(multimediaMapper);
    newsResponseMapper = NewsResponseMapper(resultMapper);

    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));

    final newsParam = Params(section: "home", apiKey: "mdlddosnonsos");

    blocTest("should get data from the get news list use case",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Right(newsResponseMapper.to(response)));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewPostRefresh(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        verify: (bloc) => newsListUseCase(newsParam));

    blocTest("should emit [NewsPostSuccess] when data is gotten successfully",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Right(newsResponseMapper.to(response)));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewPostRefresh(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [
          NewsPostInitial(),
          NewsPostSuccess(newsPost: newsResponseMapper.to(response))
        ]);

    blocTest(
        "should emit [NewsPostFailure] when data is not gotten from server",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewPostRefresh(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [NewsPostInitial(), NewsPostFailure()]);

    blocTest("should emit [NewsPostFailure] when data is not gotten from cache",
        build: () {
          when(newsListUseCase(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return newsPostBloc;
        },
        act: (bloc) => bloc.add(NewPostRefresh(
            sectionName: newsParam.section, apiKey: newsParam.apiKey)),
        expect: [NewsPostInitial(), NewsPostFailure()]);
  });
}
