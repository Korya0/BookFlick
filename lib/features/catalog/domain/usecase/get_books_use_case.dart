import 'package:bookna_app/core/api/error/failure.dart';
import 'package:bookna_app/core/api/usecase/base_use_case.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:bookna_app/features/catalog/domain/repo/books_repo.dart';
import 'package:dartz/dartz.dart';

class GetBooksUseCase extends BaseUseCase<List<Book>, NoParameters> {
  final BooksRepo _booksRepo;

  GetBooksUseCase(this._booksRepo);
  @override
  Future<Either<Failure, List<Book>>> call(p) async {
    return await _booksRepo.getBooks();
  }
}
