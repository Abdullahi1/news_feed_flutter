import 'package:floor/floor.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';

@dao
abstract class NewsDao {
  @Query('SELECT * FROM news_response WHERE section = :sectionName')
  Future<NewsResponse> getNewsResponse(String sectionName);

  @Query('DELETE  FROM news_response WHERE section = :sectionName')
  Future<void> deleteSection(String sectionName);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(NewsResponse newsResponse);
}
