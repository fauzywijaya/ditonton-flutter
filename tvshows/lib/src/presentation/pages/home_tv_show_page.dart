import 'package:core/core.dart'
    show SubHeading, kHeading6, CardImage, ItemEnum, TvShow, failedToFetchData;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tvshows/src/presentation/bloc/now_playing_tv_show/now_playing_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/bloc/popular_tv_show/popular_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/bloc/top_rated_tv_show/top_rated_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/popular_tv_show_page.dart';
import 'package:tvshows/src/presentation/pages/top_rated_tv_show_page.dart';
import 'package:tvshows/src/presentation/pages/tv_show_detail_page.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage({Key? key}) : super(key: key);

  @override
  _HomeTvShowPage createState() => _HomeTvShowPage();
}

class _HomeTvShowPage extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvShowBloc>().add(OnNowPlayingTvShowCalled());
      context.read<PopularTvShowBloc>().add(OnPopularTvShowCalled());
      context.read<TopRatedTvShowBloc>().add(OnTopRatedTvShowCalled());
    });
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
            BlocBuilder<NowPlayingTvShowBloc, NowPlayingTvShowState>(
              key: const Key('now_playing_tv_shows'),
              builder: (context, state) {
                if (state is NowPlayingTvShowLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvShowHasData) {
                  return TvShowList(
                    tvShows: state.result,
                    description: 'now_playing_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchData,
                    key: Key('error_message'),
                  );
                }
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvShowsPage.routeName),
            ),
            BlocBuilder<PopularTvShowBloc, PopularTvShowState>(
              key: const Key('popular_tv_shows'),
              builder: (context, state) {
                if (state is PopularTvShowLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvShowHasData) {
                  return TvShowList(
                    tvShows: state.result,
                    description: 'popular_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchData,
                    key: Key('error_message'),
                  );
                }
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvShowPage.routeName),
            ),
            BlocBuilder<TopRatedTvShowBloc, TopRatedTvShowState>(
              key: const Key('top_rated_tv_shows'),
              builder: (context, state) {
                if (state is TopRatedTvShowLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvShowHasData) {
                  return TvShowList(
                    tvShows: state.result,
                    description: 'top_rated_tv_shows',
                  );
                } else {
                  return const Text(
                    failedToFetchData,
                    key: Key('error_message'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;
  final String description;

  const TvShowList({
    Key? key,
    required this.tvShows,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final _tvshow = tvShows[index];
          return CardImage(
              key: Key("$description-$index"),
              activeDrawerItem: ItemEnum.TvShow,
              routeNameDestination: TvShowDetailPage.routeName,
              tvShow: _tvshow);
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
