import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_feed/features/customweb/custom_webview.dart';

class NewsTile extends StatelessWidget {
  final String newsImageUrl;
  final String newsTitle;
  final String newsAbstract;
  final String newsUrl;

  NewsTile({this.newsImageUrl, this.newsTitle, this.newsAbstract, this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return CustomWebView(
                url: newsUrl,
              );
            }),
          );
        },
        leading: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: newsImageUrl,
        ),
        title: Text(
          newsTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        subtitle: Text(
          newsAbstract,
          maxLines: 1,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
