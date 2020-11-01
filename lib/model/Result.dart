import 'Multimedia.dart';

class Result {
  String abstract;
  String byline;
  String created_date;
  List<String> des_facet;
  List<Object> geo_facet;
  String item_type;
  String kicker;
  String material_type_facet;
  List<Multimedia> multimedia;
  String published_date;
  String section;
  String short_url;
  String subsection;
  String title;
  String updated_date;
  String uri;
  String url;

  Result(
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

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      abstract: json['abstract'],
      byline: json['byline'],
      created_date: json['created_date'],
      des_facet: json['des_facet'] != null
          ? new List<String>.from(json['des_facet'])
          : null,
      geo_facet: json['geo_facet'] != null ? (json['geo_facet'] as List) : null,
      item_type: json['item_type'],
      kicker: json['kicker'],
      material_type_facet: json['material_type_facet'],
      multimedia: json['multimedia'] != null
          ? (json['multimedia'] as List)
              .map((i) => Multimedia.fromJson(i))
              .toList()
          : null,
      published_date: json['published_date'],
      section: json['section'],
      short_url: json['short_url'],
      subsection: json['subsection'],
      title: json['title'],
      updated_date: json['updated_date'],
      uri: json['uri'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['`abstract`'] = this.abstract;
    data['byline'] = this.byline;
    data['created_date'] = this.created_date;
    data['item_type'] = this.item_type;
    data['kicker'] = this.kicker;
    data['material_type_facet'] = this.material_type_facet;
    data['published_date'] = this.published_date;
    data['section'] = this.section;
    data['short_url'] = this.short_url;
    data['subsection'] = this.subsection;
    data['title'] = this.title;
    data['updated_date'] = this.updated_date;
    data['uri'] = this.uri;
    data['url'] = this.url;
    if (this.des_facet != null) {
      data['des_facet'] = this.des_facet;
    }
    if (this.geo_facet != null) {
      data['geo_facet'] = this.geo_facet;
    }
    if (this.multimedia != null) {
      data['multimedia'] = this.multimedia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
