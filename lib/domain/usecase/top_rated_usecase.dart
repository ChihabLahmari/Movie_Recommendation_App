import 'package:movies_clean_architecture_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';
import 'package:movies_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class TopRatedUseCase extends BaseUseCase {
  Repository _repository;
  TopRatedUseCase(this._repository);

  @override
  Future<Either<Failure, List<MovieObject>>> execute() async {
    return await _repository.getTopRated();
  }
}
