import 'package:floor/floor.dart';

import 'Result.dart';

@Entity(tableName: "news_response")
class NewsResponse {
  @PrimaryKey()
  String section;
  String copyright;
  String last_updated;
  int num_results;
  List<Result> results;
  String status;

  NewsResponse(
      {this.copyright,
      this.last_updated,
      this.num_results,
      this.results,
    this.section,
    this.status});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      copyright: json['copyright'],
      last_updated: json['last_updated'],
      num_results: json['num_results'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Result.fromJson(i)).toList()
          : null,
      section: json['section'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['copyright'] = this.copyright;
    data['last_updated'] = this.last_updated;
    data['num_results'] = this.num_results;
    data['section'] = this.section;
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
