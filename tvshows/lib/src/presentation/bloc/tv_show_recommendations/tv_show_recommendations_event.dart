part of 'tv_show_recommendations_bloc.dart';

@immutable
abstract class TvShowRecommendationsEvent extends Equatable {}

class OnTvShowRecommendationsCalled extends TvShowRecommendationsEvent {
  final int id;

  OnTvShowRecommendationsCalled(this.id);

  @override
  List<Object> get props => [id];
}
