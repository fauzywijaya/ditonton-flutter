import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart'
    show
        GetWatchlistTvShows,
        TvShow,
        TvShowDetail,
        RemoveTvShowWatchlist,
        SaveTvShowWatchlist,
        GetTvShowWatchlistStatus;
import 'package:equatable/equatable.dart';
part 'watchlist_tv_show_event.dart';
part 'watchlist_tv_show_state.dart';

class WatchlistTvShowBloc
    extends Bloc<WatchlistTvShowEvent, WatchlistTvShowState> {
  final GetWatchlistTvShows _getWatchlistTvShow;
  final GetTvShowWatchlistStatus _getWatchlistStatus;
  final RemoveTvShowWatchlist _removeWatchlist;
  final SaveTvShowWatchlist _saveWatchlist;

  WatchlistTvShowBloc(
    this._getWatchlistTvShow,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(TvShowWatchlistInitial()) {
    on<OnFetchTvShowWatchlist>(_onFetchTvShowWatchlist);
    on<FetchWatchlistStatus>(_fetchWatchlistStatus);
    on<AddTvShowToWatchlist>(_addTvShowToWatchlist);
    on<RemoveTvShowFromWatchlist>(_removeTvShowFromWatchlist);
  }

  FutureOr<void> _onFetchTvShowWatchlist(
    OnFetchTvShowWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    emit(TvShowWatchlistLoading());

    final result = await _getWatchlistTvShow.execute();

    result.fold(
      (failure) {
        emit(TvShowWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TvShowWatchlistEmpty())
            : emit(TvShowWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistStatus event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(TvShowIsAddedToWatchlist(result));
  }

  FutureOr<void> _addTvShowToWatchlist(
    AddTvShowToWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _saveWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(TvShowWatchlistError(failure.message));
      },
      (message) {
        emit(TvShowWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _removeTvShowFromWatchlist(
    RemoveTvShowFromWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final tvShow = event.tvShow;

    final result = await _removeWatchlist.execute(tvShow);

    result.fold(
      (failure) {
        emit(TvShowWatchlistError(failure.message));
      },
      (message) {
        emit(TvShowWatchlistMessage(message));
      },
    );
  }
}
