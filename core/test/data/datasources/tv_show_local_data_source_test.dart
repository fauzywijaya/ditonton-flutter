import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(
    () {
      mockDatabaseHelper = MockDatabaseHelper();
      dataSourceImpl =
          TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
    },
  );

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceImpl.insertWatchlist(testTvShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceImpl.insertWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceImpl.removeWatchlist(testTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceImpl.removeWatchlist(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Show Detail By Id', () {
    const tId = 1;

    test('should return TV Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowTable.toJson());
      // act
      final result = await dataSourceImpl.getTvShowById(tId);
      // assert
      expect(result, testTvShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourceImpl.getTvShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv shows', () {
    test('should return list of TVShowTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShow())
          .thenAnswer((_) async => [testTvShowTable.toJson()]);
      // act
      final result = await dataSourceImpl.getWactchlistTvShow();
      // assert
      expect(result, [testTvShowTable]);
    });
  });
}
