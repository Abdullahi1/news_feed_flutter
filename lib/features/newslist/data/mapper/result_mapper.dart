import 'package:new_feed/core/mapper/mapper.dart';
import 'package:new_feed/features/newslist/data/mapper/multimedia_mapper.dart';
import 'package:new_feed/features/newslist/data/model/Result.dart';
import 'package:new_feed/features/newslist/domain/entity/result_entity.dart';

class ResultMapper implements Mapper<ResultEntity, Result> {
  final MultimediaMapper multimediaMapper;

  ResultMapper(this.multimediaMapper);

  @override
  Result from(ResultEntity entity) => Result(
      abstract: entity.abstract,
      byline: entity.byline,
      created_date: entity.created_date,
      des_facet: entity.des_facet,
      geo_facet: entity.geo_facet,
      item_type: entity.item_type,
      kicker: entity.kicker,
      material_type_facet: entity.material_type_facet,
      multimedia: entity.multimedia != null
          ? entity.multimedia.map((e) => multimediaMapper.from(e)).toList()
          : [],
      published_date: entity.published_date,
      section: entity.section,
      short_url: entity.short_url,
      subsection: entity.subsection,
      title: entity.title,
      updated_date: entity.updated_date,
      uri: entity.uri,
      url: entity.url);

  @override
  ResultEntity to(Result domain) => ResultEntity(
      abstract: domain.abstract,
      byline: domain.byline,
      created_date: domain.created_date,
      des_facet: domain.des_facet,
      geo_facet: domain.geo_facet,
      item_type: domain.item_type,
      kicker: domain.kicker,
      material_type_facet: domain.material_type_facet,
      multimedia: domain.multimedia != null
          ? domain.multimedia.map((e) => multimediaMapper.to(e)).toList()
          : [],
      published_date: domain.published_date,
      section: domain.section,
      short_url: domain.short_url,
      subsection: domain.subsection,
      title: domain.title,
      updated_date: domain.updated_date,
      uri: domain.uri,
      url: domain.url);
}
