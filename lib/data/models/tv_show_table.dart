import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  TvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  factory TvShowTable.fromEntity(TvShowDetail model) => TvShowTable(
        id: model.id,
        name: model.name,
        posterPath: model.posterPath,
        overview: model.overview,
      );

  factory TvShowTable.fromJson(Map<String, dynamic> json) => TvShowTable(
        id: json["id"],
        name: json["name"],
        posterPath: json["posterPath"],
        overview: json["overview"],
      );

  TvShow toEntity() => TvShow.watchlist(
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      name: this.name);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
