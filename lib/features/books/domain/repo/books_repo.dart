import 'package:bookna_app/core/data/error/failure.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepo {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, List<Book>>> getAllPopularBooks(int page);
  Future<Either<Failure, List<Book>>> getAllTopRatedBooks(int page);
  Future<Either<Failure, List<Book>>> getBooksByCategoryPath(String category);
  Future<Either<Failure, List<Book>>> getBooksByTitle(String title);
}
