// Mocks generated by Mockito 5.0.17 from annotations
// in tvshows/test/helpers/bloc_test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/domain/entities/tv_show.dart' as _i9;
import 'package:core/domain/entities/tv_show_detail.dart' as _i7;
import 'package:core/domain/repositories/tv_show_repository.dart' as _i2;
import 'package:core/domain/usecases/tvshow/get_now_playing_tv_show.dart'
    as _i10;
import 'package:core/domain/usecases/tvshow/get_popular_tv_show.dart' as _i11;
import 'package:core/domain/usecases/tvshow/get_top_rated_tv_show.dart' as _i12;
import 'package:core/domain/usecases/tvshow/get_tv_show_detail.dart' as _i4;
import 'package:core/domain/usecases/tvshow/get_tv_show_recommendations.dart'
    as _i8;
import 'package:core/domain/usecases/tvshow/get_watchlist_tv_show.dart' as _i14;
import 'package:core/domain/usecases/tvshow/get_watchlist_tv_show_status.dart'
    as _i13;
import 'package:core/domain/usecases/tvshow/remove_tv_show_watchlist.dart'
    as _i16;
import 'package:core/domain/usecases/tvshow/save_tv_show_watchlist.dart'
    as _i15;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvShowRepository_0 extends _i1.Fake implements _i2.TvShowRepository {
}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvShowDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowDetail extends _i1.Mock implements _i4.GetTvShowDetail {
  MockGetTvShowDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>.value(
              _FakeEither_1<_i6.Failure, _i7.TvShowDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>);
}

/// A class which mocks [GetTvShowRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowRecommendations extends _i1.Mock
    implements _i8.GetTvShowRecommendations {
  MockGetTvShowRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetNowPlayingTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingTvShows extends _i1.Mock
    implements _i10.GetNowPlayingTvShows {
  MockGetNowPlayingTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetPopularTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvShows extends _i1.Mock implements _i11.GetPopularTvShows {
  MockGetPopularTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetTopRatedTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvShows extends _i1.Mock
    implements _i12.GetTopRatedTvShows {
  MockGetTopRatedTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetTvShowWatchlistStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowWatchlistStatus extends _i1.Mock
    implements _i13.GetTvShowWatchlistStatus {
  MockGetTvShowWatchlistStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchlistTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvShows extends _i1.Mock
    implements _i14.GetWatchlistTvShows {
  MockGetWatchlistTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [SaveTvShowWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvShowWatchlist extends _i1.Mock
    implements _i15.SaveTvShowWatchlist {
  MockSaveTvShowWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvshow) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvshow]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveTvShowWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvShowWatchlist extends _i1.Mock
    implements _i16.RemoveTvShowWatchlist {
  MockRemoveTvShowWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvshow) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvshow]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
