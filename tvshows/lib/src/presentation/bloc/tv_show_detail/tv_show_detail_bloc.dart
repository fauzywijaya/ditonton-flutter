import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart' show GetTvShowDetail, TvShowDetail;
import 'package:equatable/equatable.dart';
part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailBloc(this._getTvShowDetail) : super(TvShowDetailEmpty()) {
    on<OnTvShowDetailCalled>(_onTvShowDetailCalled);
  }

  FutureOr<void> _onTvShowDetailCalled(
    OnTvShowDetailCalled event,
    Emitter<TvShowDetailState> emit,
  ) async {
    final id = event.id;

    emit(TvShowDetailLoading());

    final result = await _getTvShowDetail.execute(id);

    result.fold(
      (failure) {
        emit(TvShowDetailError(failure.message));
      },
      (data) {
        emit(TvShowDetailHasData(data));
      },
    );
  }
}
