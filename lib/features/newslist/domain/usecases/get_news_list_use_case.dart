import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_feed/core/error/failures.dart';
import 'package:new_feed/core/usecases/usecase.dart';
import 'package:new_feed/features/newslist/domain/entity/news_entity.dart';
import 'package:new_feed/features/newslist/domain/repository/news_list_repository.dart';

class GetNewsListUseCase extends UseCase<NewsEntity, Params> {
  final NewsListRepository repository;

  GetNewsListUseCase(this.repository);

  @override
  Future<Either<Failure, NewsEntity>> call(Params params) async {
    return await repository.getNewsList(params.section, params.apiKey);
  }
}

class Params extends Equatable {
  final String section;
  final String apiKey;

  Params({@required this.section, @required this.apiKey});

  @override
  List<Object> get props => [section, apiKey];
}
