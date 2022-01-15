import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tvshow/top_rated_tv_show_page.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv_show_dummy_object.dart';
import 'top_rated_tv_show_page_test.mocks.dart';

@GenerateMocks([TopRatedTvShowNotifier])
void main() {
  late MockTopRatedTvShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvShowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display AppBar when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Top Rated Tv Shows'), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(CardList), findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(textFinder, findsOneWidget);
  });
}
