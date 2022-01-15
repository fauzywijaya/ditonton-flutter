import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowRepository repository;
  late GetTopRatedTvShows usecase;
  setUp(() {
    repository = MockTvShowRepository();
    usecase = GetTopRatedTvShows(repository);
  });
  final testTv = <TvShow>[];
  test('should get list of tv when call getTopRated on repository', () async {
    //arrange
    when(repository.getTopRatedTvShow())
        .thenAnswer((realInvocation) async => Right(testTv));
    //act
    final result = await usecase.execute();
    //assert
    verify(repository.getTopRatedTvShow());
    expect(result, Right(testTv));
  });
}
