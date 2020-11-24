import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:new_feed/core/network/network_info.dart';
import 'package:new_feed/db/app_db.dart';
import 'package:new_feed/db/news_dao.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_local_data_source.dart';
import 'package:new_feed/features/newslist/data/datasources/news_list_remote_data_source.dart';
import 'package:new_feed/features/newslist/data/mapper/multimedia_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/news_response_mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/result_mapper.dart';
import 'package:new_feed/features/newslist/data/repositories/news_list_repository_impl.dart';
import 'package:new_feed/features/newslist/domain/repository/news_list_repository.dart';
import 'package:new_feed/features/newslist/domain/usecases/get_news_list_use_case.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NewsPostBloc(getNewsListUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNewsListUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NewsListRepository>(
    () => NewsListRepositoryImpl(
        localDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
        mapper: sl()),
  );

  //mapper
  sl.registerFactory(() => NewsResponseMapper(sl()));
  sl.registerFactory(() => ResultMapper(sl()));
  sl.registerFactory(() => MultimediaMapper());

  // Data sources
  final db =
      await $FloorNewsAppDatabase.databaseBuilder('news_database.db').build();
  final dao = db.newsResponseDao;

  sl.registerLazySingleton<NewsListLocalDataSource>(
    () => NewsListLocalDataSourceImpl(dao),
  );

  sl.registerLazySingleton<NewsListRemoteDataSource>(
    () => NewsListRemoteDataSourceImpl(sl()),
  );

  //! database

  sl.registerFactory<NewsDao>(() => sl.get<NewsAppDatabase>().newsResponseDao);
  sl.registerSingletonAsync<NewsAppDatabase>(() async =>
      $FloorNewsAppDatabase.databaseBuilder('news_database.db').build());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
