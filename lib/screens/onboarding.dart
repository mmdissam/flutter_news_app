import 'package:flutter/material.dart';
import 'package:news_app_again/pagemodel.dart';
import 'package:news_app_again/screens/home_screen.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPageModel() {
    pages = List<PageModel>();
    pages.add(PageModel(
      'assets/images/bg6.jpg',
      Icons.ac_unit,
      'Welcome!',
      '1- Making friends is easy as waving your hand back and forth in easy step',
    ));
    pages.add(PageModel(
      'assets/images/bg2.jpg',
      Icons.access_alarm,
      'AlArm',
      '2- Making friends is easy as waving your hand back and forth in easy step',
    ));
    pages.add(PageModel(
      'assets/images/bg3.jpg',
      Icons.favorite,
      'Favorite',
      '3- Making friends is easy as waving your hand back and forth in easy step',
    ));
    pages.add(PageModel(
      'assets/images/bg4.jpg',
      Icons.directions_car,
      'Car',
      '4- Making friends is easy as waving your hand back and forth in easy step',
    ));
  }

  @override
  Widget build(BuildContext context) {
    _addPageModel();
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(
                          pages[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          pages[index].icons,
                          size: 100,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -100),
                      ),
                      Text(
                        pages[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          pages[index].description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: 4,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(0, 130),
            child: _displayPageIndicator(pages.length),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 18, right: 18),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.red.shade800,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        _updateSeen();
                        return HomeScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayPageIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 12,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 16,
          color: Colors.red,
        ),
      ),
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
