import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
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
      Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'),
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
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
    } else {
      throw ServerException();
    }
  }

  // Future<List<TvModel>> searchTvs(String query) async {
  //   final response = await client.get(
  //     Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
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
