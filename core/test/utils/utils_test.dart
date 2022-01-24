import 'package:core/utils/utils.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  const genres1 = [
    Genre(id: 1, name: 'genre-1'),
  ];

  const genres2 = [
    Genre(id: 1, name: 'genre-1'),
    Genre(id: 2, name: 'genre-2'),
  ];

  group('getFormattedGenres tests', () {
    test('should maches with expected string 1', () {
      const expectedString = 'genre-1';
      final result = getFormatedGenres(genres1);

      expect(result, expectedString);
    });

    test('should maches with expected string 2', () {
      const expectedString = 'genre-1, genre-2';
      final result = getFormatedGenres(genres2);

      expect(result, expectedString);
    });
  });

  group('getFormattedDuration tests', () {
    test('should matches with expected duration 1', () {
      const expected = '23m';
      final result = getFormatedDuration(23);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      const expected = '1h 12m';
      final result = getFormatedDuration(72);

      expect(result, expected);
    });
  });

  group('getFormattedDurationFromList tests', () {
    test('should matches with expected duration 1', () {
      const expected = '20m';
      final result = getFormatedDurationFromList([20]);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      const expected = '20m, 1h 12m';
      final result = getFormatedDurationFromList([20, 72]);

      expect(result, expected);
    });
  });
}
