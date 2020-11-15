import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_feed/bloc/news_post_bloc.dart';
import 'package:new_feed/bloc/news_post_event.dart';
import 'package:new_feed/bloc/news_post_state.dart';
import 'package:new_feed/model/NewsResponse.dart';
import 'package:new_feed/model/news_constant.dart';
import 'package:new_feed/news_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsFeed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("NewsFeed"),
        ),
        body: BlocProvider(
            create: (context) => NewsPostBloc()
              ..add(NewsPostFetched(
                  sectionName: NewsSections.home,
                  apiKey: NewsConstants.apiKey)),
            child: MyHomePage(title: 'NewsFeed')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  State<StatefulWidget> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  bool isWaiting;
  Future<NewsResponse> newsResponse;
  String timesNewYorkUrl =
      "https://yt3.ggpht.com/a/AATXAJyDX6fn6odU9KqLzyz1jmr6Sf2suzpO0z07ofGTew=s88-c-k-c0x00ffffff-no-rj";
  NewsPostBloc _newsPostBloc;

  @override
  void initState() {
    super.initState();
    _newsPostBloc = BlocProvider.of<NewsPostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPostBloc, NewsPostState>(builder: (context, state) {
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
                  _newsPostBloc.add(NewPostRefresh(
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
                    _newsPostBloc.add(NewPostRefresh(
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
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: state.newsPost.results.length);
      }

      return Center();
    });
  }
}
