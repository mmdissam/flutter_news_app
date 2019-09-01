import 'package:flutter/material.dart';
import 'package:news_app_again/shared_ui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Feed'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(5),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom:5),
            child: Card(
              child: Column(
                children: <Widget>[
                  _cardHeader(),
                  _cardBody(),
                  _drawDivider(),
                  _cardFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: CircleAvatar(
            backgroundImage: ExactAssetImage('assets/images/bg2.jpg'),
            radius: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Christina Meyers',style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8,),
                Text('@ch_meyers',style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            SizedBox(height: 8),
            Text('Fri, 12 May 2017 • 14.30',style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ],
    );
  }

  Widget _cardBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Container(
        child: Text(
          'We also talk about the future of work as the robots advance, and we ask whether a retro phone',
          style: TextStyle(
            fontSize: 15,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _cardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.repeat,
                color: Colors.deepOrange,
                size: 25,
              ),
              onPressed: () {},
            ),
            Text('25',style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text(
                "SHARE",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "OPEN",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _drawDivider() {
    return Container(
      width: double.infinity,
      height: 2,
      color: Colors.grey.shade200,
    );
  }
}
