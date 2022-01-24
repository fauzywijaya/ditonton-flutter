part of 'watchlist_tv_show_bloc.dart';

@immutable
abstract class WatchlistTvShowEvent extends Equatable {}

class OnFetchTvShowWatchlist extends WatchlistTvShowEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchlistStatus extends WatchlistTvShowEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvShowToWatchlist extends WatchlistTvShowEvent {
  final TvShowDetail tvShow;

  AddTvShowToWatchlist(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}

class RemoveTvShowFromWatchlist extends WatchlistTvShowEvent {
  final TvShowDetail tvShow;

  RemoveTvShowFromWatchlist(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}
