import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show SearchTvShows, TvShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_shows_event.dart';
part 'search_tv_shows_state.dart';

class SearchTvShowsBloc extends Bloc<SearchTvShowsEvent, SearchTvShowsState> {
  final SearchTvShows _searchTvShows;

  SearchTvShowsBloc(this._searchTvShows) : super(SearchTvShowsInitial()) {
    on<OnQueryTvShowsChange>(_onQueryTvShowsChange);
  }

  FutureOr<void> _onQueryTvShowsChange(
      OnQueryTvShowsChange event, Emitter<SearchTvShowsState> emit) async {
    final query = event.query;
    emit(SearchTvShowsEmpty());

    final result = await _searchTvShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTvShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchTvShowsEmpty())
            : emit(SearchTvShowsHasData(data));
      },
    );
  }

  @override
  Stream<SearchTvShowsState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}
