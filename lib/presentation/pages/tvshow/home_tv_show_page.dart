import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/item_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/tvshow/popular_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tvshow/top_rated_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tvshow/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/widgets/card_image.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvShowPage extends StatefulWidget {
  @override
  _HomeTvShowPage createState() => _HomeTvShowPage();
}

class _HomeTvShowPage extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchNowPlayingTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvShowList(data.nowPlayingTvShow);
              } else {
                return Text('Failed');
              }
            }),
            SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.popularState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvShowList(data.popularTvShow);
              } else {
                return Text('Failed');
              }
            }),
            SizedBox(height: 8.0),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvShowPage.ROUTE_NAME),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.topRatedState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvShowList(data.topRatedTvShow);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final _tvshow = tvShows[index];
          return CardImage(
              activeDrawerItem: ItemEnum.TvShow,
              routeNameDestination: TvShowDetailPage.ROUTE_NAME,
              tvShow: _tvshow);
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
