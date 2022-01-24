import 'package:core/core.dart' show CardList, ItemEnum;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/presentation/bloc/popular_movie/popular_movies_bloc.dart';
import 'package:movies/src/presentation/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        () => context.read<PopularMoviesBloc>().add(OnPopularMoviesCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          key: const Key('popular_page'),
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesHasData) {
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
                child: Text((state as PopularMoviesError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
