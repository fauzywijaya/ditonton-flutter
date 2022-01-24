import 'package:core/core.dart'
    show
        ItemEnum,
        CardList,
        routeObserver,
        kBodyText,
        failedToFetchData,
        tvShowEmptyMessage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tvshows/src/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';
import 'package:tvshows/tvshows.dart';

class WatchlistTvShowPage extends StatefulWidget {
  const WatchlistTvShowPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowPageState createState() => _WatchlistTvShowPageState();
}

class _WatchlistTvShowPageState extends State<WatchlistTvShowPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvShowBloc>().add(OnFetchTvShowWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvShowBloc>().add(OnFetchTvShowWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: BlocBuilder<WatchlistTvShowBloc, WatchlistTvShowState>(
        builder: (context, watchlistState) {
          if (watchlistState is TvShowWatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (watchlistState is TvShowWatchlistHasData) {
            final watchlistTvShow = watchlistState.result;

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = watchlistTvShow[index];

                return CardList(
                  activeItem: ItemEnum.TvShow,
                  routeName: TvShowDetailPage.routeName,
                  tvShow: tvShow,
                );
              },
              itemCount: watchlistTvShow.length,
            );
          } else if (watchlistState is TvShowWatchlistEmpty) {
            return Center(
              child: Text(tvShowEmptyMessage, style: kBodyText),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text(failedToFetchData),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
