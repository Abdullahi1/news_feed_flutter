import 'package:flutter/material.dart';
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
  List newsData = [];
  bool isWaiting;

  void getData() async {
    isWaiting = true;
    try {
      var data = await NetworkHelper(
              sectionName: "home.json",
              apiKey: "zsWKjQjfhE9P7QUGMReMppfx6FnTICGk")
          .getNewsData();

      isWaiting = false;
      setState(() {
        newsData = data;
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
      body: Builder(
        builder: (context) {
          if (isWaiting) {
            return Center(child: CircularProgressIndicator());
          } else {
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
                    newsImageUrl: newsData[index]["multimedia"][0]["url"],
                    newsTitle: newsData[index]["title"],
                    newsAbstract: newsData[index]["abstract"],
                    newsUrl: newsData[index]["url"],
                  );
                }
              },
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              itemCount: newsData.length,
            );
          }
        },
      ),
    );
  }
}
