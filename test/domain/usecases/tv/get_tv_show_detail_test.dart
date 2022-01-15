import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvshow/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowDetail(mockTvShowRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvShowDetail));
  });
}
