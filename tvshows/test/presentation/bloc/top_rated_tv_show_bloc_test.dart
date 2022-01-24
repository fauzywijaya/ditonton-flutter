import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/top_rated_tv_show/top_rated_tv_show_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetTopRatedTvShows usecase;
  late TopRatedTvShowBloc topRatedTvShowBloc;

  setUp(() {
    usecase = MockGetTopRatedTvShows();
    topRatedTvShowBloc = TopRatedTvShowBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(topRatedTvShowBloc.state, TopRatedTvShowEmpty());
  });

  blocTest<TopRatedTvShowBloc, TopRatedTvShowState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
      return topRatedTvShowBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvShowCalled()),
    expect: () => [
      TopRatedTvShowLoading(),
      TopRatedTvShowHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnTopRatedTvShowCalled().props;
    },
  );

  blocTest<TopRatedTvShowBloc, TopRatedTvShowState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvShowBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvShowCalled()),
    expect: () => [
      TopRatedTvShowLoading(),
      TopRatedTvShowError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvShowLoading(),
  );

  blocTest<TopRatedTvShowBloc, TopRatedTvShowState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return topRatedTvShowBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvShowCalled()),
    expect: () => [
      TopRatedTvShowLoading(),
      TopRatedTvShowEmpty(),
    ],
  );
}
