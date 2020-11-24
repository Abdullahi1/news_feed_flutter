import 'package:equatable/equatable.dart';
import 'package:new_feed/model/NewsResponse.dart';

class NewsPostState extends Equatable {
  NewsPostState();

  @override
  List<Object> get props => [];
}

class NewsPostInitial extends NewsPostState {}

class NewsPostFailure extends NewsPostState {}

class NewsPostSuccess extends NewsPostState {
  final NewsResponse newsPost;

  NewsPostSuccess({this.newsPost});

  @override
  List<Object> get props => [newsPost];
}
