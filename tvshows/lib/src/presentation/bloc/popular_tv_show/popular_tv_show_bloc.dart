import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart' show GetPopularTvShows, TvShow;
import 'package:equatable/equatable.dart';
part 'popular_tv_show_event.dart';
part 'popular_tv_show_state.dart';

class PopularTvShowBloc extends Bloc<PopularTvShowEvent, PopularTvShowState> {
  final GetPopularTvShows _getPopularTvShow;

  PopularTvShowBloc(this._getPopularTvShow) : super(PopularTvShowEmpty()) {
    on<OnPopularTvShowCalled>(_onPopularTvShowCalled);
  }

  FutureOr<void> _onPopularTvShowCalled(
    OnPopularTvShowCalled event,
    Emitter<PopularTvShowState> emit,
  ) async {
    emit(PopularTvShowLoading());

    final result = await _getPopularTvShow.execute();

    result.fold(
      (failure) {
        emit(PopularTvShowError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(PopularTvShowEmpty())
            : emit(PopularTvShowHasData(data));
      },
    );
  }
}
