import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tv_show.dart';
import 'package:flutter/material.dart';

class PopularTvShowNotifier extends ChangeNotifier {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowNotifier(this.getPopularTvShows);

  RequestState _state = RequestState.Empty;
  List<TvShow> _tvShows = [];
  String _message = '';

  RequestState get state => _state;
  List<TvShow> get tvShows => _tvShows;
  String get message => _message;

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final results = await getPopularTvShows.execute();

    results.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
