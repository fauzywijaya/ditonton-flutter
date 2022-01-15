import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvShowNotifier extends ChangeNotifier {
  final GetTopRatedTvShows topRatedTvShows;

  TopRatedTvShowNotifier(this.topRatedTvShows);

  RequestState _state = RequestState.Empty;
  List<TvShow> _tvShows = [];
  String _message = '';

  RequestState get state => _state;
  List<TvShow> get tvShows => _tvShows;
  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final results = await topRatedTvShows.execute();

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
