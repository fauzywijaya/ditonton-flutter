part of 'now_playing_tv_show_bloc.dart';

@immutable
abstract class NowPlayingTvShowState extends Equatable {}

class NowPlayingTvShowEmpty extends NowPlayingTvShowState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowLoading extends NowPlayingTvShowState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowError extends NowPlayingTvShowState {
  final String message;

  NowPlayingTvShowError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingTvShowHasData extends NowPlayingTvShowState {
  final List<TvShow> result;

  NowPlayingTvShowHasData(this.result);

  @override
  List<Object?> get props => [result];
}
