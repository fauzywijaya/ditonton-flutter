import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tvshow/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendations(mockTvShowRepository);
  });

  const tId = 1;
  final tTvs = <TvShow>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvs));
  });
}
