import 'package:core/core.dart' show CardList, tvShowEmptyMessage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/src/presentation/bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/watchlist_tv_show_page.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeWatchlistTvShowBloc fakeWatchlistTvShowBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistTvShowEvent());
    registerFallbackValue(FakeWatchlistTvShowState());
    fakeWatchlistTvShowBloc = FakeWatchlistTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvShowBloc>(
      create: (_) => fakeWatchlistTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeWatchlistTvShowBloc.close();
  });

  group('watchlist tv shows', () {
    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(() => fakeWatchlistTvShowBloc.state)
          .thenReturn(TvShowWatchlistLoading());

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('watchlist tv shows should display',
        (WidgetTester tester) async {
      when(() => fakeWatchlistTvShowBloc.state)
          .thenReturn(TvShowWatchlistHasData(testTvShowList));

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(CardList), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(() => fakeWatchlistTvShowBloc.state)
          .thenReturn(TvShowWatchlistEmpty());

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowPage()));

      expect(find.text(tvShowEmptyMessage), findsOneWidget);
    });
  });
}
