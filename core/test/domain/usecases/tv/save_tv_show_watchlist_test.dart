import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tvshow/save_tv_show_watchlist.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvShowWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveTvShowWatchlist(mockTvShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveWatchist(testTvShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
