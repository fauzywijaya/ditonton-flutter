import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tv_show_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';

import 'top_rated_tv_show_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late MockGetTopRatedTvShows mockGetTopRatedTVShows;
  late TopRatedTvShowNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVShows = MockGetTopRatedTvShows();
    notifier = TopRatedTvShowNotifier(mockGetTopRatedTVShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    await notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, testTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
