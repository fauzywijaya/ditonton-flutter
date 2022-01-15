import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../dummy_data/tv_show_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testMovieTableId = testMovieTable.id;
  final futureMovieId = (_) async => testMovieTableId;

  final testTVShowTableId = testTvShowTable.id;
  final futureTVShowInt = (_) async => testTVShowTableId;

  group('Movie test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result = await mockDatabaseHelper.insertWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer(futureMovieId);
      // act
      final result = await mockDatabaseHelper.removeWatchlist(testMovieTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return Movie Detail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistMovies();
      // assert
      expect(result, [testMovieMap]);
    });
  });

  group('TV Show test on db', () {
    test('should return tv show id when inserting new tv show', () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer(futureTVShowInt);
      // act
      final result =
          await mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable);
      // assert
      expect(result, testTVShowTableId);
    });

    test('should return tv show id when deleting a tv show', () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer(futureTVShowInt);
      // act
      final result =
          await mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable);
      // assert
      expect(result, testTVShowTableId);
    });

    test(
        'should return TV Show Detail Table when getting tv show by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(testTVShowTableId))
          .thenAnswer((_) async => testTvShowTable.toJson());
      // act
      final result = await mockDatabaseHelper.getTvShowById(testTVShowTableId);
      // assert
      expect(result, testTvShowTable.toJson());
    });

    test('should return null when getting tv show by id is not found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(testTVShowTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getTvShowById(testTVShowTableId);
      // assert
      expect(result, null);
    });

    test('should return list of tv show map when getting watchlist tv shows',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistTvShow();
      // assert
      expect(result, [testTvShowMap]);
    });
  });
}
