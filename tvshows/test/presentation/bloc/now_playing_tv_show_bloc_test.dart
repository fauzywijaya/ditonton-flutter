import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/now_playing_tv_show/now_playing_tv_show_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetNowPlayingTvShows usecase;
  late NowPlayingTvShowBloc nowPlayingTvShowBloc;

  setUp(() {
    usecase = MockGetNowPlayingTvShows();
    nowPlayingTvShowBloc = NowPlayingTvShowBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingTvShowBloc.state, NowPlayingTvShowEmpty());
  });

  blocTest<NowPlayingTvShowBloc, NowPlayingTvShowState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
      return nowPlayingTvShowBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowCalled()),
    expect: () => [
      NowPlayingTvShowLoading(),
      NowPlayingTvShowHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnNowPlayingTvShowCalled().props;
    },
  );

  blocTest<NowPlayingTvShowBloc, NowPlayingTvShowState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvShowBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowCalled()),
    expect: () => [
      NowPlayingTvShowLoading(),
      NowPlayingTvShowError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvShowLoading(),
  );

  blocTest<NowPlayingTvShowBloc, NowPlayingTvShowState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingTvShowBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvShowCalled()),
    expect: () => [
      NowPlayingTvShowLoading(),
      NowPlayingTvShowEmpty(),
    ],
  );
}
