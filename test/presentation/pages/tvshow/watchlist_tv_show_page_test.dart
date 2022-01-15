import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/tvshow/watchlist_tv_show_page.dart';
import 'package:ditonton/presentation/provider/tvshow/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import 'watchlist_tv_show_page_test.mocks.dart';

@GenerateMocks([WatchlistTvShowNotifier])
void main() {
  late MockWatchlistTvShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTvShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvShowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist tv shows', () {
    testWidgets('watchlist tv shows should display',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockNotifier.watchlistTvShows).thenReturn(testTvShowList);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.byType(CardList), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockNotifier.watchlistTvShows).thenReturn(<TvShow>[]);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.text(TV_SHOW_EMPTY_MESSAGE), findsOneWidget);
    });

    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
