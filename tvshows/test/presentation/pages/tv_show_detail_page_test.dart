import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tvshows/src/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';
import 'package:tvshows/src/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/tv_show_detail_page.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeTvShowDetailBloc fakeTvShowDetailBloc;
  late FakeWatchlistTvShowBloc fakeWatchlistTvShowBloc;
  late FakeTvShowRecommendationsBloc fakeTvShowRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvShowDetailEvent());
    registerFallbackValue(FakeTvShowDetailState());
    fakeTvShowDetailBloc = FakeTvShowDetailBloc();

    registerFallbackValue(FakeWatchlistTvShowEvent());
    registerFallbackValue(FakeWatchlistTvShowState());
    fakeWatchlistTvShowBloc = FakeWatchlistTvShowBloc();

    registerFallbackValue(FakeTvShowRecommendationsEvent());
    registerFallbackValue(FakeTvShowRecommendationsState());
    fakeTvShowRecommendationsBloc = FakeTvShowRecommendationsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowDetailBloc>(
          create: (_) => fakeTvShowDetailBloc,
        ),
        BlocProvider<WatchlistTvShowBloc>(
          create: (_) => fakeWatchlistTvShowBloc,
        ),
        BlocProvider<TvShowRecommendationsBloc>(
          create: (_) => fakeTvShowRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvShowDetailBloc.close();
    fakeWatchlistTvShowBloc.close();
    fakeTvShowRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeTvShowDetailBloc.state).thenReturn(TvShowDetailLoading());
    when(() => fakeWatchlistTvShowBloc.state)
        .thenReturn(TvShowWatchlistLoading());
    when(() => fakeTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeWatchlistTvShowBloc.state)
        .thenReturn(TvShowWatchlistHasData(testTvShowList));
    when(() => fakeTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tv_show_content')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeWatchlistTvShowBloc.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(() => fakeTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeWatchlistTvShowBloc.state)
        .thenReturn(TvShowIsAddedToWatchlist(true));
    when(() => fakeTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}
