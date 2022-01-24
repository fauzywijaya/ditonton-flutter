import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:core/data/models/tv_show_detail_model.dart';
import 'package:core/data/models/tv_show_model.dart';
import 'package:core/data/models/tv_show_response.dart';
import 'package:http/http.dart' as http;

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getNowPlayingTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  Future<List<TvShowModel>> getPopularTvShows();
  Future<TvShowDetailModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> searchTvShows(String query);
  Future<List<TvShowModel>> getTvShowRecommendations(int id);
}

class TvShowRemoteDataSourceImpl extends TvShowRemoteDataSource {
  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvShowModel>> getNowPlayingTvShows() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/on_the_air?$apiKey'),
    );
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(
        json.decode(response.body),
      ).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return TvShowDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  // Future<List<TvModel>> searchTvs(String query) async {
  //   final response = await client.get(
  //     Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
  //   );
  //   if (response.statusCode == 200) {
  //     return TvResponse.fromJson(
  //       json.decode(response.body),
  //     ).tvList;
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
