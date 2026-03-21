import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/core/domain/usecase/base_use_case.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:bookna_app/features/books/domain/repo/author_repo.dart';
import 'package:dartz/dartz.dart';

class GetAuthorWithNameUseCase extends BaseUseCase<List<Author>, String> {
  final AuthorRepo _authorRepo;
  GetAuthorWithNameUseCase(this._authorRepo);

  @override
  Future<Either<Failure, List<Author>>> call(String p) async {
    return await _authorRepo.getAuthorWithName(p);
  }
}
