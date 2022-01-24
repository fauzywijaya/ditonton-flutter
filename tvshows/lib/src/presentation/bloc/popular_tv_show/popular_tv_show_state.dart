part of 'popular_tv_show_bloc.dart';

@immutable
abstract class PopularTvShowState extends Equatable {}

class PopularTvShowEmpty extends PopularTvShowState {
  @override
  List<Object> get props => [];
}

class PopularTvShowLoading extends PopularTvShowState {
  @override
  List<Object> get props => [];
}

class PopularTvShowError extends PopularTvShowState {
  final String message;

  PopularTvShowError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvShowHasData extends PopularTvShowState {
  final List<TvShow> result;

  PopularTvShowHasData(this.result);

  @override
  List<Object> get props => [result];
}
