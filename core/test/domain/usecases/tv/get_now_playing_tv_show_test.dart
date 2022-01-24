import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';

import 'package:core/domain/usecases/tvshow/get_now_playing_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;
  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetNowPlayingTvShows(mockTvShowRepository);
  });
  final testTv = <TvShow>[];
  test('should get list of tv when call getNowPlayingTvs on repository',
      () async {
    //arrange
    when(mockTvShowRepository.getNowPlayingTvShows())
        .thenAnswer((_) async => Right(testTv));
    //act
    final result = await usecase.execute();
    //assert
    verify(mockTvShowRepository.getNowPlayingTvShows());
    expect(result, Right(testTv));
  });
}
