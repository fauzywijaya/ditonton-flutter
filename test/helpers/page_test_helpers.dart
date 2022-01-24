import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';
import 'package:mocktail/mocktail.dart';

/// fake search movies bloc
class FakeSearchMoviesEvent extends Fake implements SearchMoviesEvent {}

class FakeSearchMoviesState extends Fake implements SearchMoviesState {}

class FakeSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

/// fake search tv shows bloc
class FakeSearchTVShowsEvent extends Fake implements SearchTvShowsEvent {}

class FakeSearchTVShowsState extends Fake implements SearchTvShowsState {}

class FakeSearchTVShowsBloc
    extends MockBloc<SearchTvShowsEvent, SearchTvShowsState>
    implements SearchTvShowsBloc {}
