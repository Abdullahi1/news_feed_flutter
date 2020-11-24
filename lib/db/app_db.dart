import 'dart:async';

import 'package:floor/floor.dart';
import 'package:new_feed/db/converter/multimedia_converter.dart';
import 'package:new_feed/db/converter/result_converter.dart';
import 'package:new_feed/db/news_dao.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_db.g.dart';

@TypeConverters([ResultConverter, MultimediaConverter])
@Database(version: 1, entities: [NewsResponse])
abstract class NewsAppDatabase extends FloorDatabase {
  NewsDao get newsResponseDao;
}
