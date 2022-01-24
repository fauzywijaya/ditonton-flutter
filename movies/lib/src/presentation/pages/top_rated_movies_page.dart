import 'package:core/core.dart' show ItemEnum, CardList;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/presentation/bloc/top_rated_movie/top_rated_movies_bloc.dart';

import 'movie_detail_page.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
            .add(OnTopRatedMoviesCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          key: const Key('top_rated_movies'),
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return CardList(
                    activeItem: ItemEnum.Movie,
                    routeName: MovieDetailPage.routeName,
                    movie: movie,
                  );
                },
                itemCount: movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TopRatedMoviesError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
