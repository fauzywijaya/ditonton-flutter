import 'package:flutter/material.dart';
import 'package:movies/movies.dart' show WatchlistMoviesPage;
import 'package:tvshows/tvshows.dart' show WatchlistTvShowPage;
import 'package:core/core.dart' show kMikadoYellow;

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              centerTitle: true,
              title: Text('Watchlist'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  _buildTabBarItem('Movies', Icons.movie_creation_outlined),
                  _buildTabBarItem('TV Show', Icons.live_tv_rounded),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            WatchlistMoviesPage(),
            WatchlistTvShowPage(),
          ],
        ),
      )),
    );
  }

  Widget _buildTabBarItem(String title, IconData iconData) => Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            SizedBox(
              width: 12.0,
            ),
            Text(title),
          ],
        ),
      );
}
