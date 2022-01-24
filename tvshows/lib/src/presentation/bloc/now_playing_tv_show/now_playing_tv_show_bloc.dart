import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart' show GetNowPlayingTvShows, TvShow;
part 'now_playing_tv_show_event.dart';
part 'now_playing_tv_show_state.dart';

class NowPlayingTvShowBloc
    extends Bloc<NowPlayingTvShowEvent, NowPlayingTvShowState> {
  final GetNowPlayingTvShows _getNowPlayingTvShow;

  NowPlayingTvShowBloc(
    this._getNowPlayingTvShow,
  ) : super(NowPlayingTvShowEmpty()) {
    on<OnNowPlayingTvShowCalled>(_onNowPlayingTvShowCalled);
  }

  FutureOr<void> _onNowPlayingTvShowCalled(
      NowPlayingTvShowEvent event, Emitter<NowPlayingTvShowState> emit) async {
    emit(NowPlayingTvShowLoading());

    final result = await _getNowPlayingTvShow.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvShowError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(NowPlayingTvShowEmpty())
            : emit(NowPlayingTvShowHasData(data));
      },
    );
  }
}
