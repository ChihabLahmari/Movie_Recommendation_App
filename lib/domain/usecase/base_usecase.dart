import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture_mvvm/data/network/failure.dart';

abstract class BaseUseCase<Out> {
  Future<Either<Failure, Out>> execute();
}
