import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_bloc.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_event.dart';
import 'package:new_feed/features/newslist/presentation/bloc/news_post_state.dart';
import 'package:new_feed/features/newslist/presentation/widget/news_tile.dart';
import 'package:new_feed/features/utils/news_constant.dart';
import 'package:new_feed/injection_container.dart';

class NewsListPage extends StatelessWidget {
  final String timesNewYorkUrl =
      "https://yt3.ggpht.com/a/AATXAJyDX6fn6odU9KqLzyz1jmr6Sf2suzpO0z07ofGTew=s88-c-k-c0x00ffffff-no-rj";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
      ),
      body: BlocProvider<NewsPostBloc>(
          create: (context) => sl<NewsPostBloc>()
            ..add(NewsPostFetched(
                sectionName: NewsSections.home, apiKey: NewsConstants.apiKey)),
          child: BlocBuilder<NewsPostBloc, NewsPostState>(
              builder: (context, state) {
            if (state is NewsPostInitial) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is NewsPostFailure) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('failed to fetch posts'),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<NewsPostBloc>(context).add(
                            NewPostRefresh(
                                sectionName: NewsSections.home,
                                apiKey: NewsConstants.apiKey));
                      },
                      color: Colors.blue,
                      child: Text("Reload"),
                    ),
                  ],
                ),
              );
            }

            if (state is NewsPostSuccess) {
              if (state.newsPost.results.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No news currently at the moment'),
                      MaterialButton(
                        onPressed: () {
                          BlocProvider.of<NewsPostBloc>(context).add(
                              NewPostRefresh(
                                  sectionName: NewsSections.home,
                                  apiKey: NewsConstants.apiKey));
                        },
                        color: Colors.blue,
                        child: Text("Reload"),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemBuilder: (context, index) {
                    final newsData = state.newsPost.results;
                    return NewsTile(
                      newsImageUrl: newsData[index].multimedia == null
                          ? timesNewYorkUrl
                          : newsData[index].multimedia[0].url,
                      newsTitle: newsData[index].title,
                      newsAbstract: newsData[index].abstract,
                      newsUrl: newsData[index].url,
                    );
                  },
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  itemCount: state.newsPost.results.length);
            }

            return Center();
          })),
    );
  }
}
