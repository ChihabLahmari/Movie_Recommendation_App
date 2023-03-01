import 'package:dio/dio.dart';
import 'package:movies_clean_architecture_mvvm/app/constants.dart';
import 'package:movies_clean_architecture_mvvm/data/network/error_handler.dart';
import 'package:movies_clean_architecture_mvvm/data/network/failure.dart';
import 'package:movies_clean_architecture_mvvm/data/response/movie_response.dart';

abstract class RemoteDataSource {
  Future<List<MovieResponse>> getNowPlaying();
  Future<List<MovieResponse>> getPopular();
  Future<List<MovieResponse>> getTopRated();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<List<MovieResponse>> getNowPlaying() async {
    final response = await Dio()
        .get('${Constants.baseUrl}/now_playing?api_key=${Constants.apiKey}');
    print(response.statusCode);

    if (response.statusCode == AppInternalStatus.SUCCESS) {
      return List<MovieResponse>.from((response.data["results"] as List)
          .map((e) => MovieResponse.fromJson(e)));
    } else {
      throw Failure(
        AppInternalStatus.FAILURE,
        response.statusMessage ?? ResponseMessage.DEFAULT,
      );
    }
  }

  @override
  Future<List<MovieResponse>> getPopular() async {
    final response = await Dio()
        .get("${Constants.baseUrl}/popular?api_key=${Constants.apiKey}");

    if (response.statusCode == AppInternalStatus.SUCCESS) {
      return List<MovieResponse>.from((response.data["results"] as List)
          .map((e) => MovieResponse.fromJson(e)));
    } else {
      throw Failure(AppInternalStatus.FAILURE,
          response.statusMessage ?? 'error remote data source popular ');
    }
  }

  @override
  Future<List<MovieResponse>> getTopRated() async {
    final response = await Dio()
        .get("${Constants.baseUrl}/top_rated?api_key=${Constants.apiKey}");

    if (response.statusCode == AppInternalStatus.SUCCESS) {
      return List<MovieResponse>.from((response.data["results"] as List)
          .map((e) => MovieResponse.fromJson(e)));
    } else {
      throw Failure(AppInternalStatus.FAILURE,
          response.statusMessage ?? 'error remote data source top rated ');
    }
  }
}
