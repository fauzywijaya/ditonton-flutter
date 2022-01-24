import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tvshow/search_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  final testTVShows = <TvShow>[];
  const tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTVShows));
  });
}
