part of 'watchlist_tv_show_bloc.dart';

@immutable
abstract class WatchlistTvShowState extends Equatable {}

class TvShowWatchlistInitial extends WatchlistTvShowState {
  @override
  List<Object> get props => [];
}

class TvShowWatchlistEmpty extends WatchlistTvShowState {
  @override
  List<Object> get props => [];
}

class TvShowWatchlistLoading extends WatchlistTvShowState {
  @override
  List<Object> get props => [];
}

class TvShowWatchlistError extends WatchlistTvShowState {
  final String message;

  TvShowWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowWatchlistHasData extends WatchlistTvShowState {
  final List<TvShow> result;

  TvShowWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowIsAddedToWatchlist extends WatchlistTvShowState {
  final bool isAdded;

  TvShowIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TvShowWatchlistMessage extends WatchlistTvShowState {
  final String message;

  TvShowWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
