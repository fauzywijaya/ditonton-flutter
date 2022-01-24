import 'package:about/about.dart' show AboutPage;
import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart'
    show
        MovieDetailBloc,
        MovieDetailPage,
        MovieRecommendationsBloc,
        NowPlayingMoviesBloc,
        PopularMoviesBloc,
        PopularMoviesPage,
        TopRatedMoviesBloc,
        TopRatedMoviesPage,
        WatchlistMoviesBloc;
import 'package:tvshows/tvshows.dart'
    show
        NowPlayingTvShowBloc,
        PopularTvShowBloc,
        PopularTvShowsPage,
        TvShowDetailBloc,
        TvShowDetailPage,
        TvShowRecommendationsBloc,
        TopRatedTvShowBloc,
        TopRatedTvShowPage,
        WatchlistTvShowBloc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvShowsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case PopularTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedTvShowPage());
            case TvShowDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case SearchPage.routeName:
              final activeItem = settings.arguments as ItemEnum;
              return MaterialPageRoute(
                builder: (_) => SearchPage(
                  activeItem: activeItem,
                ),
              );
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
