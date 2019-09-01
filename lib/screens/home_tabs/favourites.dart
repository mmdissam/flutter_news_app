import 'dart:math';

import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}
List<int> savedHeadlinePost;

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    super.initState();
    savedHeadlinePost = [0, 2, 7];
  }

  List<Color> colorList = [
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.amber,
    Colors.blueAccent,
    Colors.deepPurpleAccent,
  ];
  Random _random = Random();

  Color _generateRandomColor() {
    return colorList[_random.nextInt(colorList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _authorRow(position),
                SizedBox(
                  height: 15,
                ),
                _newsItemsRow(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/bg2.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 40,
              height: 40,
              margin: EdgeInsets.only(
                right: 10,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Michael Adams',
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 14.5),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        '15 min. ',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'Life Style',
                        style: TextStyle(
                          color: _generateRandomColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            (savedHeadlinePost.contains(position)? (Icons.bookmark): (Icons.bookmark_border)),
            color: Colors.grey,
          ),
          onPressed: () {
            if (savedHeadlinePost.contains(position)) {
              savedHeadlinePost.remove(position);
            } else {
              savedHeadlinePost.add(position);
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _newsItemsRow() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                'assets/images/bg2.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: 100,
          height: 90,
          margin: EdgeInsets.only(right: 18,bottom: 30),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Tech Tent: Old phones and safe social',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Text(
                "We also talk about the future of work as the robots advance, and we ask whether a retro phone",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
