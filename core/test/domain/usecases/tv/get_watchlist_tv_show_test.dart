import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows usecase;
  late MockTvShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvShows(mockTVShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
