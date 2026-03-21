import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/core/domain/usecase/base_use_case.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/domain/repo/books_repo.dart';
import 'package:dartz/dartz.dart';

class GetBooksUseCase extends BaseUseCase<List<Book>, NoParameters> {
  final BooksRepo _booksRepo;

  GetBooksUseCase(this._booksRepo);
  @override
  Future<Either<Failure, List<Book>>> call(p) async {
    return await _booksRepo.getBooks();
  }
}
