import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/src/presentation/bloc/top_rated_tv_show/top_rated_tv_show_bloc.dart';
import 'package:tvshows/src/presentation/pages/top_rated_tv_show_page.dart';

import '../../dummy_data/tv_show_dummy_object.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeTopRatedTvShowBloc fakeTopRatedTvShowBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvShowEvent());
    registerFallbackValue(FakeTopRatedTvShowState());
    fakeTopRatedTvShowBloc = FakeTopRatedTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowBloc>(
      create: (_) => fakeTopRatedTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTopRatedTvShowBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display AppBar when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowHasData(testTvShowList));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Top Rated TvShow'), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows')), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TopRatedTvShowError(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
