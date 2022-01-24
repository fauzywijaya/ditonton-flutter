import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart'
    show
        baseImageUrl,
        TvShowDetail,
        ScrollableSheet,
        getFormatedDurationFromList,
        getFormatedGenres,
        addMessage,
        removeMessage,
        failedToFetchData,
        kHeading5,
        kHeading6,
        kRichBlack,
        kMikadoYellow,
        kGrey;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';
import 'package:tvshows/src/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/detail-tvshow';

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(OnTvShowDetailCalled(widget.id));
      context
          .read<TvShowRecommendationsBloc>()
          .add(OnTvShowRecommendationsCalled(widget.id));
      context.read<WatchlistTvShowBloc>().add(FetchWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTvShowAddedToWatchlist = context.select<WatchlistTvShowBloc, bool>(
        (bloc) => (bloc.state is TvShowIsAddedToWatchlist)
            ? (bloc.state as TvShowIsAddedToWatchlist).isAdded
            : false);
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
        key: const Key('tv_show_content'),
        builder: (ctx, state) {
          if (state is TvShowDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowDetailHasData) {
            final tvShow = state.result;
            return DetailContent(
              key: const Key('detail_content'),
              tvShow: tvShow,
              isTvShowAddedToWatchlist: isTvShowAddedToWatchlist,
            );
          } else {
            return const Center(child: Text(failedToFetchData));
          }
        },
      )),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvShowDetail tvShow;
  bool isTvShowAddedToWatchlist;

  DetailContent({
    Key? key,
    required this.tvShow,
    required this.isTvShowAddedToWatchlist,
  });

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      backgroundUrl: '$baseImageUrl${widget.tvShow.posterPath}',
      scrollableContents: [
        Text(
          widget.tvShow.name,
          style: kHeading5,
        ),
        ElevatedButton(
          onPressed: () async {
            if (!widget.isTvShowAddedToWatchlist) {
              context
                  .read<WatchlistTvShowBloc>()
                  .add(AddTvShowToWatchlist(widget.tvShow));
            } else {
              context
                  .read<WatchlistTvShowBloc>()
                  .add(RemoveTvShowFromWatchlist(widget.tvShow));

              final state = BlocProvider.of<WatchlistTvShowBloc>(context).state;
              String message = "";

              if (state is TvShowIsAddedToWatchlist) {
                final isAdded = state.isAdded;
                message = isAdded == false ? addMessage : removeMessage;
              } else {
                message = !widget.isTvShowAddedToWatchlist
                    ? addMessage
                    : removeMessage;
              }

              if (message == addMessage || message == removeMessage) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(message),
                      );
                    });
              }

              setState(() {
                widget.isTvShowAddedToWatchlist =
                    !widget.isTvShowAddedToWatchlist;
              });
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isTvShowAddedToWatchlist
                  ? const Icon(Icons.check)
                  : const Icon(Icons.add),
              const SizedBox(width: 6.0),
              const Text('Watchlist'),
              const SizedBox(width: 4.0),
            ],
          ),
        ),
        Text(
          getFormatedGenres(widget.tvShow.genres),
        ),
        Text(
          widget.tvShow.episodeRunTime.isNotEmpty
              ? getFormatedDurationFromList(widget.tvShow.episodeRunTime)
              : 'N/A',
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: widget.tvShow.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${widget.tvShow.voteAverage}')
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'Total Episodes: ' + widget.tvShow.numberOfEpisodes.toString(),
        ),
        Text(
          'Total Seasons: ' + widget.tvShow.numberOfSeasons.toString(),
        ),
        const SizedBox(height: 16),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(
          widget.tvShow.overview.isNotEmpty ? widget.tvShow.overview : "-",
        ),
        const SizedBox(height: 16),
        Text(
          'Recommendations',
          style: kHeading6,
        ),
        BlocBuilder<TvShowRecommendationsBloc, TvShowRecommendationsState>(
          key: const Key('recommendation_tv_show'),
          builder: (context, state) {
            if (state is TvShowRecommendationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowRecommendationsHasData) {
              final tvShowRecommendations = state.result;

              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tvShowRecoms = tvShowRecommendations[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            TvShowDetailPage.routeName,
                            arguments: tvShowRecoms.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: '$baseImageUrl${tvShowRecoms.posterPath}',
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: tvShowRecommendations.length,
                ),
              );
            } else {
              return const Text('No recommendations found');
            }
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Seasons',
          style: kHeading6,
        ),
        widget.tvShow.seasons.isNotEmpty
            ? Container(
                height: 150,
                margin: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    final season = widget.tvShow.seasons[index];

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            season.posterPath == null
                                ? Container(
                                    width: 96.0,
                                    decoration: const BoxDecoration(
                                      color: kGrey,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: kRichBlack),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        '$baseImageUrl${season.posterPath}',
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                            Positioned.fill(
                              child: Container(
                                color: kRichBlack.withOpacity(0.65),
                              ),
                            ),
                            Positioned(
                              left: 8.0,
                              top: 4.0,
                              child: Text(
                                (index + 1).toString(),
                                style: kHeading5.copyWith(fontSize: 26.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: widget.tvShow.seasons.length,
                ),
              )
            : const Text('-'),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
