import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

import 'package:ditonton/domain/usecases/tvshow/get_popular_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows usecase;
  late MockTvShowRepository repository;
  setUp(() {
    repository = MockTvShowRepository();
    usecase = GetPopularTvShows(repository);
  });
  final testTv = <TvShow>[];
  test('should get list of tv when call getPopularTvs on repository', () async {
    //arrange

    when(repository.getPopularTvShows()).thenAnswer((_) async => Right(testTv));
    //act
    final result = await usecase.execute();
    //assert
    verify(repository.getPopularTvShows());
    expect(result, Right(testTv));
  });
}
