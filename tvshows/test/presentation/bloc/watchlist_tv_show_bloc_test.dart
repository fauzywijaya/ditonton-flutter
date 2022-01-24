import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshows/src/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetWatchlistTvShows getWatchlistTvShow;
  late MockGetTvShowWatchlistStatus getWatchlistStatus;
  late MockRemoveTvShowWatchlist removeWatchlist;
  late MockSaveTvShowWatchlist saveWatchlist;
  late WatchlistTvShowBloc watchlistTvShowBloc;

  setUp(() {
    getWatchlistTvShow = MockGetWatchlistTvShows();
    getWatchlistStatus = MockGetTvShowWatchlistStatus();
    removeWatchlist = MockRemoveTvShowWatchlist();
    saveWatchlist = MockSaveTvShowWatchlist();
    watchlistTvShowBloc = WatchlistTvShowBloc(
      getWatchlistTvShow,
      getWatchlistStatus,
      removeWatchlist,
      saveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchlistTvShowBloc.state, TvShowWatchlistInitial());
  });

  group(
    'get watchlist tv shows test cases',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(getWatchlistTvShow.execute())
              .thenAnswer((_) async => Right(testWatchlistTvShow));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          TvShowWatchlistLoading(),
          TvShowWatchlistHasData(testWatchlistTvShow),
        ],
        verify: (bloc) {
          verify(getWatchlistTvShow.execute());
          return OnFetchTvShowWatchlist().props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(getWatchlistTvShow.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          TvShowWatchlistLoading(),
          TvShowWatchlistError('Server Failure'),
        ],
        verify: (bloc) => TvShowWatchlistLoading(),
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(getWatchlistTvShow.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          TvShowWatchlistLoading(),
          TvShowWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(getWatchlistStatus.execute(testTvShowDetail.id))
              .thenAnswer((_) async => true);
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testTvShowDetail.id)),
        expect: () => [
          TvShowIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testTvShowDetail.id));
          return FetchWatchlistStatus(testTvShowDetail.id).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(getWatchlistStatus.execute(testTvShowDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testTvShowDetail.id)),
        expect: () => [
          TvShowIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testTvShowDetail.id));
          return FetchWatchlistStatus(testTvShowDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(saveWatchlist.execute(testTvShowDetail))
              .thenAnswer((_) async => const Right(addMessage));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(AddTvShowToWatchlist(testTvShowDetail)),
        expect: () => [
          TvShowWatchlistMessage(addMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testTvShowDetail));
          return AddTvShowToWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(saveWatchlist.execute(testTvShowDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(AddTvShowToWatchlist(testTvShowDetail)),
        expect: () => [
          TvShowWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testTvShowDetail));
          return AddTvShowToWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(removeWatchlist.execute(testTvShowDetail))
              .thenAnswer((_) async => const Right(removeMessage));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(RemoveTvShowFromWatchlist(testTvShowDetail)),
        expect: () => [
          TvShowWatchlistMessage(removeMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testTvShowDetail));
          return RemoveTvShowFromWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(removeWatchlist.execute(testTvShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(RemoveTvShowFromWatchlist(testTvShowDetail)),
        expect: () => [
          TvShowWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testTvShowDetail));
          return RemoveTvShowFromWatchlist(testTvShowDetail).props;
        },
      );
    },
  );
}
