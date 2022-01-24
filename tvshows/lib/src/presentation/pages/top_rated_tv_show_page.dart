import 'package:core/core.dart' show ItemEnum, CardList;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/src/presentation/bloc/top_rated_tv_show/top_rated_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/tv_show_detail_page.dart';

class TopRatedTvShowPage extends StatefulWidget {
  static const routeName = '/top-rated-tvshow';

  @override
  _TopRatedTvShowPageState createState() => _TopRatedTvShowPageState();
}

class _TopRatedTvShowPageState extends State<TopRatedTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TopRatedTvShowBloc>(context, listen: false)
            .add(OnTopRatedTvShowCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowBloc, TopRatedTvShowState>(
          key: const Key('top_rated_tv_shows'),
          builder: (context, state) {
            if (state is TopRatedTvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvShowHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data[index];

                  return CardList(
                    activeItem: ItemEnum.TvShow,
                    routeName: TvShowDetailPage.routeName,
                    tvShow: tvShow,
                  );
                },
                itemCount: data.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TopRatedTvShowError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
