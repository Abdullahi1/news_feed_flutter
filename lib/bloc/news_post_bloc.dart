import 'package:bloc/bloc.dart';
import 'package:new_feed/bloc/news_post_event.dart';
import 'package:new_feed/bloc/news_post_state.dart';
import 'package:new_feed/network_model.dart';

class NewsPostBloc extends Bloc<NewsPostEvent, NewsPostState> {
  NewsPostBloc() : super(NewsPostInitial());

  @override
  Stream<NewsPostState> mapEventToState(NewsPostEvent event) async* {
    final currentState = state;
    if (event is NewsPostFetched) {
      try {
        if (currentState is NewsPostInitial) {
          var helper = NetworkHelper(
              sectionName: event.sectionName, apiKey: event.apiKey);

          final newsPost = await helper.getNewsData();
          yield NewsPostSuccess(newsPost: newsPost);
        }
      } catch (e) {
        yield NewsPostFailure();
      }
    } else if (event is NewPostRefresh) {
      yield NewsPostInitial();

      try {
        if (state is NewsPostInitial) {
          var helper = NetworkHelper(
              sectionName: event.sectionName, apiKey: event.apiKey);

          final newsPost = await helper.getNewsData();
          yield NewsPostSuccess(newsPost: newsPost);
        }
      } catch (e) {
        yield NewsPostFailure();
      }
    }
  }
}
