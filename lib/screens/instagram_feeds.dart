import 'package:flutter/material.dart';
import 'package:news_app_again/shared_ui/navigation_drawer.dart';

class InstagramFeeds extends StatefulWidget {
  @override
  _InstagramFeedsState createState() => _InstagramFeedsState();
}

class _InstagramFeedsState extends State<InstagramFeeds> {
  List<int> savedInstagramPost = [0, 2, 7];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Feeds'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _cardHeader(position),
                  _text(),
                  _comment(),
                  _picture(),
                  _drawDivider(),
                  _shareAndLike(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 12),
              child: CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/bg2.jpg'),
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Christina Meyers',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 8,
                ),
                Text('Fri, 12 May 2017 • 14.30',
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (savedInstagramPost.contains(position)
                      ? (Colors.red)
                      : (Colors.grey.shade600)),
                  size: 25,
                ),
                onPressed: () {
                  if (savedInstagramPost.contains(position)) {
                    savedInstagramPost.remove(position);
                  } else {
                    savedInstagramPost.add(position);
                  }
                  setState(() {});
                }),
            Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                '25',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _text() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Text(
        'We also talk about the future of work as the robots',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _comment() {
    return Wrap(
      spacing: -35,
      children: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text(
              '#advance',
              style: TextStyle(color: Colors.orange),
            )),
        FlatButton(
            onPressed: () {},
            child: Text(
              '#retro',
              style: TextStyle(color: Colors.orange),
            )),
        FlatButton(
            onPressed: () {},
            child: Text(
              '#instagram',
              style: TextStyle(color: Colors.orange),
            )),
      ],
    );
  }

  Widget _picture() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/bg3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
    );
  }

  Widget _shareAndLike() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text('10 COMMENTS', style: TextStyle(color: Colors.orange))),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text(
                "SHARE",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "OPEN",
                style: TextStyle(color: Colors.orange),
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
