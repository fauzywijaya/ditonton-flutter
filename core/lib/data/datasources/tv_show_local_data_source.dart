import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlist(TvShowTable tvshow);
  Future<String> removeWatchlist(TvShowTable tvshow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getWactchlistTvShow();
}

class TvShowLocalDataSourceImpl extends TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;
  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromJson(result);
    }
  }

  @override
  Future<List<TvShowTable>> getWactchlistTvShow() async {
    final results = await databaseHelper.getWatchlistTvShow();
    return results
        .map(
          (data) => TvShowTable.fromJson(data),
        )
        .toList();
  }

  @override
  Future<String> insertWatchlist(TvShowTable tvshow) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvshow);
      return addMessage;
    } catch (e) {
      throw (DatabaseException(
        e.toString(),
      ));
    }
  }

  @override
  Future<String> removeWatchlist(TvShowTable tvshow) async {
    try {
      await databaseHelper.removeTvShowWatchlist(tvshow);
      return removeMessage;
    } catch (e) {
      throw (DatabaseException(
        e.toString(),
      ));
    }
  }
}
