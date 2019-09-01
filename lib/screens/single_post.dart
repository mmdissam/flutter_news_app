import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app_again/models/post.dart';

class SinglePost extends StatefulWidget {
  final Post post;

  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.post.featuredImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, position) {
                if (position == 0) {
                  return _drawPostDetails();
                } else if (position == 1) {
                  return _numberOfComment();
                } else if (position > 1 && position < 24) {
                  return _comment();
                } else {
                  return _commentTextEntry();
                }
              },
              childCount: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawPostDetails() {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.post.content,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 1.2,
                wordSpacing: 1.2,
                height: 1.2,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        _drawDivider(),
      ],
    );
  }

  Widget _comment() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.post.featuredImage),
                radius: 25,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Christina",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "1 hour",
                    style:
                        TextStyle(fontSize: 14.5, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable...",
            style: TextStyle(
              fontSize: 15.5,
              color: Colors.brown.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentTextEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write comment here...",
                    contentPadding:
                        EdgeInsets.only(left: 16, bottom: 24, top: 24),
                  ),
                ),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    "SEND",
                    style: TextStyle(color: Colors.red.shade800, fontSize: 16),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberOfComment() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        child: Text(
          "Comment (24)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color getRandomColor({int minBrightness = 50}) {
  final random = Random();
  assert(minBrightness >= 0 && minBrightness <= 255);
  return Color.fromARGB(
    0xFF,
    minBrightness + random.nextInt(255 - minBrightness),
    minBrightness + random.nextInt(255 - minBrightness),
    minBrightness + random.nextInt(255 - minBrightness),
  );
}

Widget _drawDivider() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Container(
      width: double.infinity,
      height: 3,
      color: Colors.grey.shade200,
    ),
  );
}
