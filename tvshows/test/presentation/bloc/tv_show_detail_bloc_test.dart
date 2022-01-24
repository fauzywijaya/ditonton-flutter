import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetTvShowDetail usecase;
  late TvShowDetailBloc tvShowDetailBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvShowDetailCalled(testId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailHasData(testTvShowDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return OnTvShowDetailCalled(testId).props;
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvShowDetailCalled(testId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailError('Server Failure'),
    ],
    verify: (bloc) => TvShowDetailLoading(),
  );
}
