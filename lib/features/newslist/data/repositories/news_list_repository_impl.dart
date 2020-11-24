import 'package:dartz/dartz.dart';
import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/core/error/failures.dart';
import 'package:new_feed/core/network/network_info.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_local_data_source.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_remote_data_source.dart';
import 'package:new_feed/features/newslist/data/mapper/news_response_mapper.dart';
import 'package:new_feed/features/newslist/domain/entity/news_entity.dart';
import 'package:new_feed/features/newslist/domain/repository/news_list_repository.dart';

class NewsListRepositoryImpl implements NewsListRepository {
  final NewsListLocalDataSource localDataSource;
  final NewsListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final NewsResponseMapper mapper;

  NewsListRepositoryImpl(
      {this.localDataSource,
      this.remoteDataSource,
      this.networkInfo,
      this.mapper});

  @override
  Future<Either<Failure, NewsEntity>> getNewsList(
      String section, String apiKey) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsList =
            await remoteDataSource.getNewsList(section, apiKey);
        await localDataSource.deleteNews(section);
        await localDataSource.insertNews(remoteNewsList);
        return Right(mapper.to(remoteNewsList));
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure());
        } else {
          return Left(CacheFailure());
        }
      }
    } else {
      try {
        final localNewsList = await localDataSource.getNewsList(section);
        return Right(mapper.to(localNewsList));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
