import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tvshow/search_tv_show.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/tv_show_dummy_object.dart';

import 'search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTVShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTVShows = MockSearchTvShows();
    provider = SearchNotifier(
        searchMovies: mockSearchMovies, searchTvShows: mockSearchTVShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final testQueryMovie = 'spiderman';
  final testQueryTVShow = 'squid game';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      provider.fetchMovieSearchResults(testQueryMovie);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await provider.fetchMovieSearchResults(testQueryMovie);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.movieSearchResults, testMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearchResults(testQueryMovie);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVShows.execute(testQueryTVShow))
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchTvShowSearchResults(testQueryTVShow);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTVShows.execute(testQueryTVShow))
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchTvShowSearchResults(testQueryTVShow);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvShowSearchResults, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVShows.execute(testQueryTVShow))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearchResults(testQueryTVShow);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
