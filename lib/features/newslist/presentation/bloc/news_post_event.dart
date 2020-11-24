import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewsPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsPostFetched extends NewsPostEvent {
  final String sectionName;
  final String apiKey;

  NewsPostFetched({@required this.sectionName, @required this.apiKey});

  @override
  List<Object> get props => [sectionName, apiKey];
}

class NewPostRefresh extends NewsPostEvent {
  final String sectionName;
  final String apiKey;

  NewPostRefresh({@required this.sectionName, @required this.apiKey});

  @override
  List<Object> get props => [sectionName, apiKey];
}
