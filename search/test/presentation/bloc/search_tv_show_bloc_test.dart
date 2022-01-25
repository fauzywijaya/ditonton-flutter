import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/src/presentation/bloc/search_tv_shows_bloc.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockSearchTvShows mockSearchTvShow;
  late SearchTvShowsBloc searchTvShowBloc;

  setUp(() {
    mockSearchTvShow = MockSearchTvShows();
    searchTvShowBloc = SearchTvShowsBloc(mockSearchTvShow);
  });

  const testQuery = 'Money Heist';

  test('the initial state should be Initial state', () {
    expect(searchTvShowBloc.state, SearchTvShowsInitial());
  });

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'should emit HasData state when data successfully fetched',
    build: () {
      when(mockSearchTvShow.execute(testQuery))
          .thenAnswer((_) async => Right(testTVShowList));
      return searchTvShowBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShow.execute(testQuery));
      return OnQueryTvShowsChange(testQuery).props;
    },
  );

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'should emit Error state when the searched data failed to fetch',
    build: () {
      when(mockSearchTvShow.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvShowBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShow.execute(testQuery));
      return SearchTvShowsLoading().props;
    },
  );

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'should emit Empty state when the searched data is empty',
    build: () {
      when(mockSearchTvShow.execute(testQuery))
          .thenAnswer((_) async => const Right([]));
      return searchTvShowBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTvShowsEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTvShow.execute(testQuery));
    },
  );
}
