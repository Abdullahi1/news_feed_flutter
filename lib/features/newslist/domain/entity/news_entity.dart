import 'package:equatable/equatable.dart';

import 'result_entity.dart';

class NewsEntity extends Equatable {
  String section;
  String copyright;
  String last_updated;
  int num_results;
  List<ResultEntity> results;
  String status;

  NewsEntity(
      {this.copyright,
      this.last_updated,
      this.num_results,
      this.results,
      this.section,
      this.status});

  @override
  List<Object> get props =>
      [section, copyright, last_updated, num_results, results, status];
}
