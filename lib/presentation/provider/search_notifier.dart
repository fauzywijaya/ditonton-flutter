import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tvshow/search_tv_show.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.Empty;
  List<Movie> _movieSearchResults = [];
  List<TvShow> _tvShowSearchResults = [];
  String _message = '';

  RequestState get state => _state;
  List<Movie> get movieSearchResults => _movieSearchResults;
  List<TvShow> get tvShowSearchResults => _tvShowSearchResults;
  String get message => _message;

  void resetDataSearch() {
    _state = RequestState.Empty;
    _movieSearchResults = [];
    _tvShowSearchResults = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearchResults(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final results = await searchMovies.execute(query);
    results.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (success) {
        _movieSearchResults = success;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvShowSearchResults(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final results = await searchTvShows.execute(query);
    results.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (success) {
        _tvShowSearchResults = success;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
