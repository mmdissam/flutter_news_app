import 'package:flutter/material.dart';
import 'package:news_app_again/pages/about.dart';
import 'package:news_app_again/pages/contact.dart';
import 'package:news_app_again/pages/help.dart';
import 'package:news_app_again/pages/sitting.dart';
import 'package:news_app_again/pages/sitting.dart';
import 'package:news_app_again/shared_ui/navigation_drawer.dart';
import 'home_tabs/favourites.dart';
import 'home_tabs/popular.dart';
import 'home_tabs/whats_new.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu { HELP, ABOUT, CONTACT, SITTING }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          _popOutMenu(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "WHAT'S NEW",
            ),
            Tab(
              text: "POPULAR",
            ),
            Tab(
              text: "FAVOURITES",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: Center(
        child: TabBarView(
          children: [
            WhatsNew(),
            Popular(),
            Favourites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _popOutMenu(context) {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.ABOUT,
              child: Text('ABOUT'),
            ),
            PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.CONTACT,
              child: Text('CONTACT'),
            ),
            PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.HELP,
              child: Text('HELP'),
            ),
            PopupMenuItem<PopOutMenu>(
              value: PopOutMenu.SITTING,
              child: Text('SITTING'),
            ),
          ];
        },
        onSelected: (PopOutMenu menu) {
          switch (menu) {
            case PopOutMenu.ABOUT:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return About();
              }));
              break;
            case PopOutMenu.HELP:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Help();
              }));
              break;
            case PopOutMenu.CONTACT:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactUs();
              }));
              break;
            case PopOutMenu.SITTING:
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Sitting();
              }));
              break;
          }
        });
  }
}
