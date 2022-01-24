import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetTvShowRecommendations usecase;
  late TvShowRecommendationsBloc tvShowRecommendationsBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetTvShowRecommendations();
    tvShowRecommendationsBloc = TvShowRecommendationsBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(tvShowRecommendationsBloc.state, TvShowRecommendationsEmpty());
  });

  blocTest<TvShowRecommendationsBloc, TvShowRecommendationsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => Right(testTvShowList));
      return tvShowRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvShowRecommendationsCalled(testId)),
    expect: () => [
      TvShowRecommendationsLoading(),
      TvShowRecommendationsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return OnTvShowRecommendationsCalled(testId).props;
    },
  );

  blocTest<TvShowRecommendationsBloc, TvShowRecommendationsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvShowRecommendationsCalled(testId)),
    expect: () => [
      TvShowRecommendationsLoading(),
      TvShowRecommendationsError('Server Failure'),
    ],
    verify: (bloc) => TvShowRecommendationsLoading(),
  );

  blocTest<TvShowRecommendationsBloc, TvShowRecommendationsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute(testId)).thenAnswer((_) async => const Right([]));
      return tvShowRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvShowRecommendationsCalled(testId)),
    expect: () => [
      TvShowRecommendationsLoading(),
      TvShowRecommendationsEmpty(),
    ],
  );
}
