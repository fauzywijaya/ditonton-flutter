import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class GetTopRatedTvShows {
  final TvShowRepository repository;
  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShow();
  }
}
