part of 'search_tv_shows_bloc.dart';

@immutable
abstract class SearchTvShowsEvent extends Equatable {}

class OnQueryTvShowsChange extends SearchTvShowsEvent {
  final String query;

  OnQueryTvShowsChange(this.query);

  @override
  List<Object> get props => [query];
}
