import 'package:equatable/equatable.dart';

import 'multimedia_entity.dart';

class ResultEntity extends Equatable {
  String abstract;
  String byline;
  String created_date;
  List<String> des_facet;
  List<Object> geo_facet;
  String item_type;
  String kicker;
  String material_type_facet;
  List<MultimediaEntity> multimedia;
  String published_date;
  String section;
  String short_url;
  String subsection;
  String title;
  String updated_date;
  String uri;
  String url;

  ResultEntity(
      {this.abstract,
      this.byline,
      this.created_date,
      this.des_facet,
      this.geo_facet,
      this.item_type,
      this.kicker,
      this.material_type_facet,
      this.multimedia,
      this.published_date,
      this.section,
      this.short_url,
      this.subsection,
      this.title,
      this.updated_date,
      this.uri,
      this.url});

  @override
  List<Object> get props => [
        abstract,
        byline,
        created_date,
        des_facet,
        geo_facet,
        item_type,
        kicker,
        material_type_facet,
        multimedia,
        published_date,
        section,
        short_url,
        section,
        title,
        updated_date,
        uri,
        url
      ];
}
