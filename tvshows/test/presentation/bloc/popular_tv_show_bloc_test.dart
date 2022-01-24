import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/popular_tv_show/popular_tv_show_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetPopularTvShows usecase;
  late PopularTvShowBloc popularTvShowBloc;

  setUp(() {
    usecase = MockGetPopularTvShows();
    popularTvShowBloc = PopularTvShowBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(popularTvShowBloc.state, PopularTvShowEmpty());
  });

  blocTest<PopularTvShowBloc, PopularTvShowState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
      return popularTvShowBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowCalled()),
    expect: () => [
      PopularTvShowLoading(),
      PopularTvShowHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnPopularTvShowCalled().props;
    },
  );

  blocTest<PopularTvShowBloc, PopularTvShowState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvShowBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowCalled()),
    expect: () => [
      PopularTvShowLoading(),
      PopularTvShowError('Server Failure'),
    ],
    verify: (bloc) => PopularTvShowLoading(),
  );

  blocTest<PopularTvShowBloc, PopularTvShowState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return popularTvShowBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvShowCalled()),
    expect: () => [
      PopularTvShowLoading(),
      PopularTvShowEmpty(),
    ],
  );
}
