import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/item_enum.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/tvshow/home_tv_show_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = '/home';
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (ctx, data, child) {
      final activeItem = data.selectedItem;

      return Scaffold(
        key: _drawerKey,
        drawer: _buildDrawer(ctx, (ItemEnum newSelectedItem) {
          data.setSelectedItem(newSelectedItem);
        }, activeItem),
        appBar: _buildAppBar(ctx, activeItem),
        body: _buildBody(ctx, activeItem),
      );
    });
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
                SearchPage.ROUTE_NAME,
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
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      );
}
