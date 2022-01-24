part of 'tv_show_recommendations_bloc.dart';

@immutable
abstract class TvShowRecommendationsState extends Equatable {}

class TvShowRecommendationsEmpty extends TvShowRecommendationsState {
  @override
  List<Object> get props => [];
}

class TvShowRecommendationsLoading extends TvShowRecommendationsState {
  @override
  List<Object> get props => [];
}

class TvShowRecommendationsError extends TvShowRecommendationsState {
  final String message;

  TvShowRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRecommendationsHasData extends TvShowRecommendationsState {
  final List<TvShow> result;

  TvShowRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
