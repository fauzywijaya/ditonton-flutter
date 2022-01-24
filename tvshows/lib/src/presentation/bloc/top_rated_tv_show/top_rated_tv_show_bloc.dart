import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart' show GetTopRatedTvShows, TvShow;
import 'package:equatable/equatable.dart';
part 'top_rated_tv_show_event.dart';
part 'top_rated_tv_show_state.dart';

class TopRatedTvShowBloc
    extends Bloc<TopRatedTvShowEvent, TopRatedTvShowState> {
  final GetTopRatedTvShows _getTopRatedTvShow;

  TopRatedTvShowBloc(
    this._getTopRatedTvShow,
  ) : super(TopRatedTvShowEmpty()) {
    on<OnTopRatedTvShowCalled>(_onTopRatedTvShowCalled);
  }

  FutureOr<void> _onTopRatedTvShowCalled(
    OnTopRatedTvShowCalled event,
    Emitter<TopRatedTvShowState> emit,
  ) async {
    emit(TopRatedTvShowLoading());

    final result = await _getTopRatedTvShow.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvShowError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TopRatedTvShowEmpty())
            : emit(TopRatedTvShowHasData(data));
      },
    );
  }
}
