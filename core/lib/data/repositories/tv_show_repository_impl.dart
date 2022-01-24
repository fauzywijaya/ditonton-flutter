import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tv_show_local_data_source.dart';
import 'package:core/data/datasources/tv_show_remote_data_source.dart';
import 'package:core/data/models/tv_show_table.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl extends TvShowRepository {
  final TvShowLocalDataSource localDataSource;
  final TvShowRemoteDataSource remoteDataSource;

  TvShowRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() async {
    try {
      final results = await remoteDataSource.getPopularTvShows();
      return Right(results.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow() async {
    try {
      final results = await remoteDataSource.getTopRatedTvShows();
      return Right(results.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id) async {
    try {
      final results = await remoteDataSource.getTvShowRecommendations(id);
      return Right(results.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows() async {
    final results = await localDataSource.getWactchlistTvShow();

    return Right(results.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvShowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvshow) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvShowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchist(TvShowDetail tvshow) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvShowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) async {
    try {
      final results = await remoteDataSource.searchTvShows(query);
      return Right(results.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(
        ServerFailure(''),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }
}
