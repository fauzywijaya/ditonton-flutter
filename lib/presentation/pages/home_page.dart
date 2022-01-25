import 'package:about/about.dart' show AboutPage;
import 'package:movies/movies.dart' show HomeMoviePage;

import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:search/search.dart' show SearchPage;
import 'package:tvshows/tvshows.dart' show HomeTvShowPage;
import 'package:core/core.dart' show ItemEnum, kDavysGrey, kGrey;

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  ItemEnum _selectedItem = ItemEnum.Movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: _buildDrawer(context, (ItemEnum newSelectedItem) {
        setState(() {
          _selectedItem = newSelectedItem;
        });
      }, _selectedItem),
      appBar: _buildAppBar(context, _selectedItem),
      body: _buildBody(context, _selectedItem),
    );
  }

  Widget _buildBody(BuildContext context, ItemEnum selectedItem) {
    if (selectedItem == ItemEnum.Movie) {
      return HomeMoviePage();
    } else if (selectedItem == ItemEnum.TvShow) {
      return HomeTvShowPage();
    }
    return Container();
  }

  AppBar _buildAppBar(
    BuildContext context,
    ItemEnum activeItem,
  ) =>
      AppBar(
        centerTitle: true,
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.routeName,
                arguments: activeItem,
              );
            },
            icon: Icon(Icons.search_rounded),
          ),
        ],
      );

  Drawer _buildDrawer(BuildContext context, Function(ItemEnum) itemCallback,
          ItemEnum activeItem) =>
      Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              tileColor: activeItem == ItemEnum.Movie ? kDavysGrey : kGrey,
              leading: Icon(Icons.movie_creation_outlined),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(ItemEnum.Movie);
              },
            ),
            ListTile(
              tileColor: activeItem == ItemEnum.TvShow ? kDavysGrey : kGrey,
              leading: Icon(Icons.live_tv_rounded),
              title: Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(ItemEnum.TvShow);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, WatchlistPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      );
}
