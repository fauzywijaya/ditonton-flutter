import 'package:core/core.dart'
    show Movie, RequestState, SearchMovies, SearchTvShows, TvShow;
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _moviesSearchResult = [];

  List<Movie> get moviesSearchResult => _moviesSearchResult;

  List<TvShow> _tvShowsSearchResult = [];

  List<TvShow> get tvShowsSearchResult => _tvShowsSearchResult;

  String _message = '';

  String get message => _message;

  void resetData() {
    _state = RequestState.Empty;
    _moviesSearchResult = [];
    _tvShowsSearchResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _moviesSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvShowsSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
