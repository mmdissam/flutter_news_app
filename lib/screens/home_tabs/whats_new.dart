import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app_again/api/posts_api.dart';
import 'dart:async';
import 'package:news_app_again/models/post.dart';
import 'package:news_app_again/screens/single_post.dart';
import 'package:news_app_again/utilities/data_utitities.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostAPI postAPI = PostAPI();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdates(),
          SizedBox(
            height: 28,
          ),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 24,
    );
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return FutureBuilder(
      future: postAPI.fetchPostsByCategoryId("1"),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
            connectionError();
            break;
          case ConnectionState.done:
            if(snapshot.hasError){
              return error(snapshot.error);
            }else{
              if(!snapshot.hasData){
                return noData();
              }else{
                List<Post> posts = snapshot.data;
                Random random = Random();
                int index = random.nextInt(posts.length);
                Post post = posts[index];

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SinglePost(post);
                    }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.featuredImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 34, right: 34),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                post.title,
                                style: _headerTitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 26, right: 26),
                              child: Text(
                                post.content.substring(0,75),
                                style: _headerDescription,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            break;
        }
        return null;
      }
    );
  }

  Widget _drawTopStories() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: FutureBuilder(
                future: postAPI.fetchPostsByCategoryId("1"),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return loading();
                      break;
                    case ConnectionState.active:
                      return loading();
                      break;
                    case ConnectionState.none:
                      connectionError();
                      break;
                    case ConnectionState.done:
                      if (snapShot.hasError) {
                        return error(snapShot.error);
                      } else {
                        if (snapShot.hasData) {
                          List<Post> posts = snapShot.data;
                          if (posts.length >= 3) {
                            Post post1 = snapShot.data[0];
                            Post post2 = snapShot.data[1];
                            Post post3 = snapShot.data[2];
                            return Column(
                              children: <Widget>[
                                _drawSingleRow(post1),
                                _drawDivider(),
                                _drawSingleRow(post2),
                                _drawDivider(),
                                _drawSingleRow(post3),
                              ],
                            );
                          }else{
                            return noData();
                          }
                        }else{
                          return noData();
                        }
                      }
                      break;
                  }
                  return noData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(post);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Image.network(post.featuredImage, fit: BoxFit.cover),
              width: 90,
              height: 100,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Michael',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.access_alarm),
                            Text(parseHumanDateTime(post.dateWritten)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade200,
    );
  }

  Widget _drawRecentUpdates() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: FutureBuilder(
        future: postAPI.fetchPostsByCategoryId("2"),
        builder: (context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return connectionError();
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return error(snapshot.error);
              } else {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 10),
                        child: _drawSectionTitle('Recent Updates'),
                      ),
                      _drawUpdatesCard(Colors.deepOrange.shade600, 'SPORT',
                          snapshot.data[0]),
                      _drawUpdatesCard(Colors.lightGreen.shade600, 'LIFESTYLE',
                          snapshot.data[1]),
                    ],
                  );
                }else {
                  return noData();
                }
              }
              break;
          }
          return null;
        },
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
    );
  }

  Widget _drawUpdatesCard(Color color, String text, Post post) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(post);
        }));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.featuredImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, bottom: 8),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    parseHumanDateTime(post.dateWritten),
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
