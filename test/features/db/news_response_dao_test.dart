import 'package:flutter_test/flutter_test.dart';
import 'package:new_feed/db/app_db.dart';
import 'package:new_feed/db/news_dao.dart';

void main() {
  NewsAppDatabase database;
  NewsDao newsDao;

  setUp(() async {
    database = await $FloorNewsAppDatabase.inMemoryDatabaseBuilder().build();
    newsDao = database.newsResponseDao;
  });

  tearDown(() async {
    await database.close();
  });
}
