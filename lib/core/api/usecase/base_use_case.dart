import 'package:bookna_app/core/api/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<T, P> {
  Future<Either<Failure, T>> call(P p);
}

class NoParameters {}
