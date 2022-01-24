import 'package:core/core.dart'
    show ItemEnum, Movie, TvShow, kBodyText, kHeading6, CardList;
import 'package:ditonton/presentation/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart' show MovieDetailPage;
import 'package:provider/provider.dart';
import 'package:tvshows/tvshows.dart' show TvShowDetailPage;

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  SearchPage({
    Key? key,
    required this.activeItem,
  }) : super(key: key);

  final ItemEnum activeItem;
  late String _title;

  @override
  Widget build(BuildContext context) {
    _title = activeItem == ItemEnum.Movie ? "Movie" : "TV Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $_title\s'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (activeItem == ItemEnum.Movie)
                  context
                      .read<SearchMoviesBloc>()
                      .add(OnQueryMoviesChange(query));
                else
                  context
                      .read<SearchTvShowsBloc>()
                      .add(OnQueryTvShowsChange(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (activeItem == ItemEnum.Movie) {
      return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        key: const Key('search_movies'),
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchMoviesHasData) {
            final movies = state.result;
            return _buildMovieCardList(movies);
          } else if (state is SearchMoviesEmpty) {
            return _buildMovieCardList([]);
          } else if (state is SearchMoviesError) {
            return _buildErrorMessage();
          } else {
            return Container();
          }
        },
      );
    } else {
      return BlocBuilder<SearchTvShowsBloc, SearchTvShowsState>(
        key: const Key('search_tv_shows'),
        builder: (context, state) {
          if (state is SearchTvShowsLoading) {
            return Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SearchTvShowsHasData) {
            final tvShows = state.result;
            return _buildTVShowCardList(tvShows);
          } else if (state is SearchTvShowsEmpty) {
            return _buildTVShowCardList([]);
          } else if (state is SearchTvShowsError) {
            return _buildErrorMessage();
          } else {
            return Container();
          }
        },
      );
    }
  }

  Widget _buildMovieCardList(List<Movie> movies) {
    if (movies.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return CardList(
              movie: movie,
              activeItem: activeItem,
              routeName: MovieDetailPage.routeName);
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _buildTVShowCardList(List<TvShow> tvShows) {
    if (tvShows.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return CardList(
            tvShow: tvShow,
            activeItem: activeItem,
            routeName: TvShowDetailPage.routeName,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }

  Widget _buildErrorMessage() => Container(
        key: const Key('error_message'),
        margin: EdgeInsets.only(top: 32.0),
        child: Center(
          child: Text(
            '$_title\s not found!',
            style: kBodyText,
          ),
        ),
      );
}
