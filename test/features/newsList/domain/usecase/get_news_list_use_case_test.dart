import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_feed/features/newslist/data/mapper/multimedia_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/news_response_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/result_mapper.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';
import 'package:new_feed/features/newslist/domain/entity/news_entity.dart';
import 'package:new_feed/features/newslist/domain/repository/news_list_repository.dart';
import 'package:new_feed/features/newslist/domain/usecases/get_news_list_use_case.dart';

import '../../../../testData/fixture_reader.dart';

class MockNewsListRepository extends Mock implements NewsListRepository {}

void main() {
  GetNewsListUseCase getNewsListUseCase;
  MockNewsListRepository mockNewsListRepository;

  MultimediaMapper multimediaMapper;
  ResultMapper resultMapper;
  NewsResponseMapper newsResponseMapper;

  setUp(() {
    mockNewsListRepository = MockNewsListRepository();
    getNewsListUseCase = GetNewsListUseCase(mockNewsListRepository);
    multimediaMapper = MultimediaMapper();
    resultMapper = ResultMapper(multimediaMapper);
    newsResponseMapper = NewsResponseMapper(resultMapper);
  });

  test("Should get news from the repository", () async {
    final NewsResponse response =
        NewsResponse.fromJson(jsonDecode(fixture("newsData.json")));
    final NewsEntity entity = newsResponseMapper.to(response);

    final newsParam = Params(section: "home", apiKey: "mdlddosnonsos");

    // given that the repository produce a newsResponse from the endpoint
    when(mockNewsListRepository.getNewsList(any, any))
        .thenAnswer((_) async => Right(entity));

    // make call to the repository
    final result = await getNewsListUseCase.call(newsParam);

    //assert that the result is true or false
    expect(result, Right(entity));
    verify(mockNewsListRepository.getNewsList(
        newsParam.section, newsParam.apiKey));
    verifyNoMoreInteractions(mockNewsListRepository);
  });
}
