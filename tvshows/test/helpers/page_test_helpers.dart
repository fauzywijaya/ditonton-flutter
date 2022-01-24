import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/tvshows.dart';

/// fake now playing tv shows bloc
class FakeNowPlayingTvShowEvent extends Fake implements NowPlayingTvShowEvent {}

class FakeNowPlayingTvShowState extends Fake implements NowPlayingTvShowState {}

class FakeNowPlayingTvShowBloc
    extends MockBloc<NowPlayingTvShowEvent, NowPlayingTvShowState>
    implements NowPlayingTvShowBloc {}

/// fake popular tv shows bloc
class FakePopularTvShowEvent extends Fake implements PopularTvShowEvent {}

class FakePopularTvShowState extends Fake implements PopularTvShowState {}

class FakePopularTvShowBloc
    extends MockBloc<PopularTvShowEvent, PopularTvShowState>
    implements PopularTvShowBloc {}

/// fake top rated tv shows bloc
class FakeTopRatedTvShowEvent extends Fake implements TopRatedTvShowEvent {}

class FakeTopRatedTvShowState extends Fake implements TopRatedTvShowState {}

class FakeTopRatedTvShowBloc
    extends MockBloc<TopRatedTvShowEvent, TopRatedTvShowState>
    implements TopRatedTvShowBloc {}

/// fake detail tv show bloc
class FakeTvShowDetailEvent extends Fake implements TvShowDetailEvent {}

class FakeTvShowDetailState extends Fake implements TvShowDetailState {}

class FakeTvShowDetailBloc
    extends MockBloc<TvShowDetailEvent, TvShowDetailState>
    implements TvShowDetailBloc {}

/// fake tv show recommendations bloc
class FakeTvShowRecommendationsEvent extends Fake
    implements TvShowRecommendationsEvent {}

class FakeTvShowRecommendationsState extends Fake
    implements TvShowRecommendationsState {}

class FakeTvShowRecommendationsBloc
    extends MockBloc<TvShowRecommendationsEvent, TvShowRecommendationsState>
    implements TvShowRecommendationsBloc {}

/// fake watchlist tv shows bloc
class FakeWatchlistTvShowEvent extends Fake implements WatchlistTvShowEvent {}

class FakeWatchlistTvShowState extends Fake implements WatchlistTvShowState {}

class FakeWatchlistTvShowBloc
    extends MockBloc<WatchlistTvShowEvent, WatchlistTvShowState>
    implements WatchlistTvShowBloc {}
