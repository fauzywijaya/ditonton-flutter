import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tv_show_status.dart';
import 'package:ditonton/domain/usecases/tvshow/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tvshow/save_tv_show_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetTvShowWatchlistStatus getTvShowWatchlistStatus;
  final SaveTvShowWatchlist saveTvShowWatchlist;
  final RemoveTvShowWatchlist removeTvShowWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getTvShowWatchlistStatus,
    required this.saveTvShowWatchlist,
    required this.removeTvShowWatchlist,
  });

  late TvShowDetail _tvShowDetail;
  TvShowDetail get tvShowDetail => _tvShowDetail;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResults = await getTvShowRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.Loading;
        _tvShowDetail = tvShow;
        notifyListeners();

        recommendationResults.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (recommendations) {
            _tvShowRecommendations = recommendations;
            _recommendationState = RequestState.Loaded;
            notifyListeners();
          },
        );
        _tvShowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    final result = await saveTvShowWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (success) async {
        _watchlistMessage = success;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeWatchlist(TvShowDetail tvShow) async {
    final result = await removeTvShowWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (success) async {
        _watchlistMessage = success;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvShowWatchlistStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
