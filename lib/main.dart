import 'package:flutter/material.dart';
import 'package:new_feed/model/NewsResponse.dart';
import 'package:new_feed/network_model.dart';
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
      home: MyHomePage(title: 'NewsFeed'),
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

  void getData() {
    isWaiting = true;
    try {
      //print(data);
      isWaiting = false;
      setState(() {
        var helper = NetworkHelper(
            sectionName: "home.json",
            apiKey: "zsWKjQjfhE9P7QUGMReMppfx6FnTICGk");

        newsResponse = helper.getNewsData();
      });
    } catch (e) {
      print(e);
      print(e.runtimeType);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<NewsResponse>(
          future: newsResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final newsData = snapshot.data.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index == newsData.length) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {
                    return NewsTile(
                      newsImageUrl: newsData[index].multimedia == null
                          ? timesNewYorkUrl
                          : newsData[index].multimedia[0].url,
                      newsTitle: newsData[index].title,
                      newsAbstract: newsData[index].abstract,
                      newsUrl: newsData[index].url,
                    );
                  }
                },
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                itemCount: newsData.length,
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${snapshot.error}"),
                  MaterialButton(
                    onPressed: () {
                      getData();
                    },
                    color: Colors.blue,
                    child: Text("Reload"),
                  ),
                ],
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
