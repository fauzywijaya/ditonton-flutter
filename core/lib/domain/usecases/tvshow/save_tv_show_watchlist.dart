import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class SaveTvShowWatchlist {
  final TvShowRepository repository;

  SaveTvShowWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvshow) {
    return repository.saveWatchist(tvshow);
  }
}
