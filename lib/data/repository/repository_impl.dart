import 'package:movies_clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:movies_clean_architecture_mvvm/data/mapper/mapper.dart';
import 'package:movies_clean_architecture_mvvm/data/network/error_handler.dart';
import 'package:movies_clean_architecture_mvvm/data/network/network_info.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';
import 'package:movies_clean_architecture_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture_mvvm/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<MovieObject>>> getNowPlaying() async {
    if (await _networkInfo.isConnected) {
      try {
        print("🔥calling data");
        final response = await _remoteDataSource.getNowPlaying();
        try {
          print("✅data go to right");
          return right(response.map((e) => e.toDomain()).toList());
        } on Failure catch (failure) {
          print("🛑data go to left");
          print(failure.message);

          return left(failure);
        }
      } catch (error) {
        print("🛑cashe error");
        print(error.toString());
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieObject>>> getPopular() async {
    if (await _networkInfo.isConnected) {
      try {
        print("🔥calling remote data source get popular");

        final response = await _remoteDataSource.getPopular();
        try {
          print("✅popular go to right");

          return right(response.map((e) => e.toDomain()).toList());
        } on Failure catch (failure) {
          print("🛑popular go to left");
          print(failure.message);
          return left(failure);
        }
      } catch (error) {
        print("🛑popular cashe error");

        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieObject>>> getTopRated() async {
    if (await _networkInfo.isConnected) {
      try {
        print("🔥calling remote data source top rated");

        final response = await _remoteDataSource.getTopRated();
        try {
          print("✅top rated go to right");

          return right(response.map((e) => e.toDomain()).toList());
        } on Failure catch (failure) {
          print("🛑top rated go to left");
          print(failure.message);
          return left(failure);
        }
      } catch (error) {
        print("🛑top rated cashe error");

        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
