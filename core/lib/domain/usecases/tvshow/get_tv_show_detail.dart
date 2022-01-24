import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';

class GetTvShowDetail {
  final TvShowRepository repository;
  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
