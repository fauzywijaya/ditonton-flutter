import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/src/presentation/bloc/popular_tv_show/popular_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/popular_tv_show_page.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakePopularTvShowBloc fakePopularTvShowBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvShowEvent());
    registerFallbackValue(FakePopularTvShowState());
    fakePopularTvShowBloc = FakePopularTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowBloc>(
      create: (_) => fakePopularTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakePopularTvShowBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvShowBloc.state).thenReturn(PopularTvShowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display AppBar, ListView, and popular page when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowHasData(testTvShowList));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Popular Tv Shows'), findsOneWidget);
    expect(find.byKey(const Key('popular_page')), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakePopularTvShowBloc.state)
        .thenReturn(PopularTvShowError(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
