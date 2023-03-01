import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture_mvvm/data/network/failure.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';

abstract class Repository {
  Future<Either<Failure, List<MovieObject>>> getNowPlaying();

  Future<Either<Failure, List<MovieObject>>> getPopular();

  Future<Either<Failure, List<MovieObject>>> getTopRated();
}
