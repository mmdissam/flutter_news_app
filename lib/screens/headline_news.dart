import 'package:flutter/material.dart';
import 'package:news_app_again/screens/home_tabs/favourites.dart';
import 'package:news_app_again/shared_ui/navigation_drawer.dart';

import 'home_tabs/popular.dart';

class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews>  with SingleTickerProviderStateMixin{
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
        title: Text('Headline News'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
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
            Favourites(),
            Popular(),
            Favourites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
