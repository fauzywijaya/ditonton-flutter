import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class RemoveTvShowWatchlist {
  final TvShowRepository repository;
  RemoveTvShowWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvshow) {
    return repository.removeWatchlist(tvshow);
  }
}
