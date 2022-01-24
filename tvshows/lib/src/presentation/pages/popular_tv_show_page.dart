import 'package:core/core.dart' show CardList, ItemEnum;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tvshows/src/presentation/bloc/popular_tv_show/popular_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/tv_show_detail_page.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const routeName = '/popular-tvshow';

  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvShowBloc>().add(OnPopularTvShowCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowBloc, PopularTvShowState>(
          key: const Key('popular_page'),
          builder: (context, state) {
            if (state is PopularTvShowLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowHasData) {
              final tvShows = state.result;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = tvShows[index];

                  return CardList(
                    activeItem: ItemEnum.TvShow,
                    routeName: TvShowDetailPage.routeName,
                    tvShow: tvShow,
                  );
                },
                itemCount: tvShows.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as PopularTvShowError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
