import 'package:bookna_app/core/api/error/failure.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:dartz/dartz.dart';

abstract class AuthorRepo {
  Future<Either<Failure, List<Author>>> getAuthorWithName(String name);
}
