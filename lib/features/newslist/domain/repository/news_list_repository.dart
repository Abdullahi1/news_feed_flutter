import 'package:dartz/dartz.dart';
import 'package:new_feed/core/error/failures.dart';
import 'package:new_feed/features/newslist/domain/entity/news_entity.dart';

abstract class NewsListRepository {
  Future<Either<Failure, NewsEntity>> getNewsList(
      String section, String apiKey);
}
