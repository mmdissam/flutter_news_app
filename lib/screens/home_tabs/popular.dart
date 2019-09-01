import 'package:flutter/material.dart';
import 'package:news_app_again/models/post.dart';
import 'package:news_app_again/api/posts_api.dart';
import 'package:news_app_again/screens/single_post.dart';
import 'dart:async';
import 'package:news_app_again/utilities/data_utitities.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostAPI postAPI = PostAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postAPI.fetchPostsByCategoryId("3"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              List<Post> posts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    child: _drawSingleRow(posts[position]),
                  );
                },
                itemCount: posts.length ,
              );
            }
            break;
        }
        return null;
      },
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SinglePost(post);
          }));
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Image(
                image: NetworkImage(post.featuredImage),
                fit: BoxFit.cover,
              ),
              width: 100,
              height: 90,
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
                        padding: const EdgeInsets.only(right: 35),
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

}
