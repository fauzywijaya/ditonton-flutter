import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/src/presentation/bloc/now_playing_tv_show/now_playing_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/bloc/popular_tv_show/popular_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/bloc/top_rated_tv_show/top_rated_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/home_tv_show_page.dart';
import 'package:tvshows/src/presentation/pages/popular_tv_show_page.dart';
import 'package:tvshows/src/presentation/pages/top_rated_tv_show_page.dart';
import 'package:tvshows/src/presentation/pages/tv_show_detail_page.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/app_helpers.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeNowPlayingTvShowBloc fakeNowPlayingTvShowBloc;
  late FakePopularTvShowBloc fakePopularTvShowBloc;
  late FakeTopRatedTvShowBloc fakeTopRatedTvShowBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingTvShowEvent());
    registerFallbackValue(FakeNowPlayingTvShowState());
    fakeNowPlayingTvShowBloc = FakeNowPlayingTvShowBloc();

    registerFallbackValue(FakePopularTvShowEvent());
    registerFallbackValue(FakePopularTvShowState());
    fakePopularTvShowBloc = FakePopularTvShowBloc();

    registerFallbackValue(FakeTopRatedTvShowEvent());
    registerFallbackValue(FakeTopRatedTvShowState());
    fakeTopRatedTvShowBloc = FakeTopRatedTvShowBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingTvShowBloc.close();
    fakePopularTvShowBloc.close();
    fakeTopRatedTvShowBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvShowBloc>(
          create: (context) => fakeNowPlayingTvShowBloc,
        ),
        BlocProvider<PopularTvShowBloc>(
          create: (context) => fakePopularTvShowBloc,
        ),
        BlocProvider<TopRatedTvShowBloc>(
          create: (context) => fakeTopRatedTvShowBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvShowBloc>(
          create: (context) => fakeNowPlayingTvShowBloc,
        ),
        BlocProvider<PopularTvShowBloc>(
          create: (context) => fakePopularTvShowBloc,
        ),
        BlocProvider<TopRatedTvShowBloc>(
          create: (context) => fakeTopRatedTvShowBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const HomeTvShowPage()),
    TvShowDetailPage.routeName: (context) => const FakeDestination(),
    TopRatedTvShowPage.routeName: (context) => const FakeDestination(),
    PopularTvShowsPage.routeName: (context) => const FakeDestination(),
    '/search': (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowLoading());
    when(() => fakePopularTvShowBloc.state).thenReturn(PopularTvShowLoading());
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeTvShowPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of now-playing-tv_shows when HasData state occurred',
      (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeTvShowPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowError('error'));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowError('error'));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeTvShowPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets(
      'Doing action "tap" on one of the Now Playing card should go to TvShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('now_playing_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('now_playing_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Popular TvShow card should go to TvShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('popular_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );

    await tester.tap(find.byKey(const Key('popular_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Top Rated TvShow card should go to TvShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });
}
