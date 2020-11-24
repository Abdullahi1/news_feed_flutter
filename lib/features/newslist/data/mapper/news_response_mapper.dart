import 'package:new_feed/core/mapper/mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/result_mapper.dart';
import 'package:new_feed/features/newslist/data/model/NewsResponse.dart';
import 'package:new_feed/features/newslist/domain/entity/news_entity.dart';

class NewsResponseMapper implements Mapper<NewsEntity, NewsResponse> {
  final ResultMapper resultMapper;

  NewsResponseMapper(this.resultMapper);

  @override
  NewsResponse from(NewsEntity entity) => NewsResponse(
        copyright: entity.copyright,
        last_updated: entity.last_updated,
        num_results: entity.num_results,
        results: entity.results.map((e) => resultMapper.from(e)).toList(),
        section: entity.section,
        status: entity.status,
      );

  @override
  NewsEntity to(NewsResponse domain) => NewsEntity(
        copyright: domain.copyright,
        last_updated: domain.last_updated,
        num_results: domain.num_results,
        results: domain.results.map((e) => resultMapper.to(e)).toList(),
        section: domain.section,
        status: domain.status,
      );
}
