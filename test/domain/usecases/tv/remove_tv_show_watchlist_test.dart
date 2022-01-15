import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvshow/remove_tv_show_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvShowWatchlist usecase;
  late MockTvShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvShowRepository();
    usecase = RemoveTvShowWatchlist(mockTVShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.removeWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTVShowRepository.removeWatchlist(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
