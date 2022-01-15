import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_now_playing_tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:flutter/foundation.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowPlayingTvShows = <TvShow>[];
  List<TvShow> get nowPlayingTvShow => _nowPlayingTvShows;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShow => _popularTvShows;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShow => _topRatedTvShows;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getNowPlayingTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetNowPlayingTvShows getNowPlayingTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchNowPlayingTvShows() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final results = await getNowPlayingTvShows.execute();

    results.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final results = await getPopularTvShows.execute();

    results.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _popularState = RequestState.Loaded;
        _popularTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final results = await getTopRatedTvShows.execute();

    results.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
