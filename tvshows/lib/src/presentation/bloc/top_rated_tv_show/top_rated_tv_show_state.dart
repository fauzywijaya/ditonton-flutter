part of 'top_rated_tv_show_bloc.dart';

@immutable
abstract class TopRatedTvShowState extends Equatable {}

class TopRatedTvShowEmpty extends TopRatedTvShowState {
  @override
  List<Object> get props => [];
}

class TopRatedTvShowLoading extends TopRatedTvShowState {
  @override
  List<Object> get props => [];
}

class TopRatedTvShowError extends TopRatedTvShowState {
  final String message;

  TopRatedTvShowError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvShowHasData extends TopRatedTvShowState {
  final List<TvShow> result;

  TopRatedTvShowHasData(this.result);

  @override
  List<Object> get props => [result];
}
