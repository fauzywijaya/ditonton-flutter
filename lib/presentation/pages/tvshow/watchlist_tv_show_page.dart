import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/item_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tvshow/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvShowPage extends StatefulWidget {
  @override
  _WatchlistTvShowPageState createState() => _WatchlistTvShowPageState();
}

class _WatchlistTvShowPageState extends State<WatchlistTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: Consumer<WatchlistTvShowNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistTvShows.isEmpty)
              return Center(
                child: Text(TV_SHOW_EMPTY_MESSAGE, style: kBodyText),
              );

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = data.watchlistTvShows[index];

                return CardList(
                  activeItem: ItemEnum.TvShow,
                  routeName: TvShowDetailPage.ROUTE_NAME,
                  tvShow: tvShow,
                );
              },
              itemCount: data.watchlistTvShows.length,
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
