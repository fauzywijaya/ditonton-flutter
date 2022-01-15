import 'package:ditonton/common/item_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvshow';

  @override
  _TopRatedTvShowPageState createState() => _TopRatedTvShowPageState();
}

class _TopRatedTvShowPageState extends State<TopRatedTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvShowNotifier>(context, listen: false)
            .fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvShowNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];

                  return CardList(
                    activeItem: ItemEnum.TvShow,
                    routeName: TvShowDetailPage.ROUTE_NAME,
                    tvShow: tvShow,
                  );
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
