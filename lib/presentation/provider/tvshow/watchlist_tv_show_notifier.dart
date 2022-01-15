import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tv_show.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowNotifier({required this.getWatchlistTvShows});

  var _watchlistTvShows = <TvShow>[];
  var _watchlistState = RequestState.Empty;
  String _message = '';

  List<TvShow> get watchlistTvShows => _watchlistTvShows;
  RequestState get watchlistState => _watchlistState;
  String get message => _message;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final results = await getWatchlistTvShows.execute();
    results.fold(
      (failure) {
        _message = failure.message;
        _watchlistState = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistTvShows = tvShowsData;
        _watchlistState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
