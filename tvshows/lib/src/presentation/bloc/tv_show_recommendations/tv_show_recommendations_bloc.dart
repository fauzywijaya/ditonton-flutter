import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart' show GetTvShowRecommendations, TvShow;
import 'package:equatable/equatable.dart';
part 'tv_show_recommendations_event.dart';
part 'tv_show_recommendations_state.dart';

class TvShowRecommendationsBloc
    extends Bloc<TvShowRecommendationsEvent, TvShowRecommendationsState> {
  final GetTvShowRecommendations _getTvShowRecommendations;

  TvShowRecommendationsBloc(this._getTvShowRecommendations)
      : super(TvShowRecommendationsEmpty()) {
    on<OnTvShowRecommendationsCalled>(_onTvShowRecommendationsCalled);
  }

  FutureOr<void> _onTvShowRecommendationsCalled(
    OnTvShowRecommendationsCalled event,
    Emitter<TvShowRecommendationsState> emit,
  ) async {
    final id = event.id;
    emit(TvShowRecommendationsLoading());

    final result = await _getTvShowRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TvShowRecommendationsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TvShowRecommendationsEmpty())
            : emit(TvShowRecommendationsHasData(data));
      },
    );
  }
}
