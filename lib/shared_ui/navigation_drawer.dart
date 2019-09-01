import 'package:flutter/material.dart';
import 'package:news_app_again/models/nav_menu.dart';
import 'package:news_app_again/screens/facebook_feeds.dart';
import 'package:news_app_again/screens/headline_news.dart';
import 'package:news_app_again/screens/home_screen.dart';
import 'package:news_app_again/screens/instagram_feeds.dart';
import 'package:news_app_again/screens/login.dart';
import 'package:news_app_again/screens/twitter_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  static bool isLoggedIn = false;
  String token;
  SharedPreferences sharedPreferences;

  List<NavMenuItem> navigationMenu = [
    NavMenuItem('Explore', () => HomeScreen()),
    NavMenuItem('Headline News', () => HeadLineNews()),
    NavMenuItem('Twitter Feeds', () => TwitterFeed()),
    NavMenuItem('Instagram Feeds', () => InstagramFeeds()),
    NavMenuItem('Facebook Feeds', () => FacebookFeeds()),
    NavMenuItem('Login', () => Login()),
  ];

  _logout() async {
      if (sharedPreferences != null) {
        sharedPreferences.remove('token');
    }
      return HomeScreen();

  }

  _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token');
    setState(() {
      if(token == null){
        isLoggedIn = false;
      }else{
        isLoggedIn = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if(isLoggedIn){
      navigationMenu.add(NavMenuItem('Logout', () => _logout));
    }
  }

  List<String> navMenu = [
    "Explore",
    "Headline News",
    "Read Later",
    "Videos",
    "Photos",
    "Sitting",
    "Logout",
  ];

  @override
  Widget build(BuildContext context) {
    if(this.mounted){
      _checkToken();
    }

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                  title: Text(
                    navigationMenu[position].title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => navigationMenu[position].destination()));
                  }),
            );
          },
          itemCount: navigationMenu.length,
        ),
      ),
    );
  }


}
