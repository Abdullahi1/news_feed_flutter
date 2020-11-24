import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_feed/features/newslist/domain/usecases/get_news_list_use_case.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_event.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_state.dart';

class NewsPostBloc extends Bloc<NewsPostEvent, NewsPostState> {
  final GetNewsListUseCase getNewsListUseCase;

  NewsPostBloc({@required this.getNewsListUseCase})
      : assert(getNewsListUseCase != null),
        super(NewsPostInitial());

  @override
  Stream<NewsPostState> mapEventToState(NewsPostEvent event) async* {
    final currentState = state;
    if (event is NewsPostFetched) {
      if (currentState is NewsPostInitial) {
        final result = await getNewsListUseCase(
            Params(section: event.sectionName, apiKey: event.apiKey));

        yield* result.fold((failure) async* {
          yield NewsPostFailure();
        }, (newsPost) async* {
          yield NewsPostSuccess(newsPost: newsPost);
        });
      }
    } else if (event is NewPostRefresh) {
      yield NewsPostInitial();

      final result = await getNewsListUseCase(
          Params(section: event.sectionName, apiKey: event.apiKey));

      yield* result.fold((failure) async* {
        yield NewsPostFailure();
      }, (newsPost) async* {
        yield NewsPostSuccess(newsPost: newsPost);
      });
    }
  }
}
