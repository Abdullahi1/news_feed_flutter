import 'package:new_feed/core/error/exception.dart';
import 'package:new_feed/db/news_dao.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';

abstract class NewsListLocalDataSource {
  Future<NewsResponse> getNewsList(String section);

  Future<void> insertNews(NewsResponse newsResponse);

  Future<void> deleteNews(String section);
}

class NewsListLocalDataSourceImpl extends NewsListLocalDataSource {
  final NewsDao newsDao;

  NewsListLocalDataSourceImpl(this.newsDao);

  @override
  Future<NewsResponse> getNewsList(String section) async {
    try {
      final newsList = await newsDao.getNewsResponse(section);

      if (newsList != null) {
        return Future.value(newsList);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> insertNews(NewsResponse newsResponse) async {
    try {
      return await newsDao.insertNews(newsResponse);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNews(String section) async {
    try {
      return await newsDao.deleteSection(section);
    } catch (e) {
      throw CacheException();
    }
  }
}
